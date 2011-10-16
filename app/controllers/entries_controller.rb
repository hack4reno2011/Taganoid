class EntriesController < ApplicationController

  def index
    @search = Entry.search(params[:q])
    @search.sorts = 'descr asc' if @search.sorts.empty?
    @entries = @search.result.paginate(page: params[:page])
  end

  def show
    @entry = Entry.find(params[:id])
  end
  
  def new
    @entry = Entry.new
  end

  def edit
    @entry = Entry.find(params[:id]) if Entry.exists?(params[:id])
    unless @entry
      flash[:error] = "Entry ID #{params[:id]} does not exist"
      redirect_to(entries_path)
    end
  end


  def create
    @entry = Entry.new(params[:entry])
    if @entry.save
      flash[:success] = 'Successfully created Entry'
      redirect_to entries_url
    else
      flash.now[:error] = @entry.errors.full_messages.join("<br>").html_safe
      render :action => :new
    end
  end


  def update
    @entry = Entry.find(params[:id]) if Entry.exists?(params[:id])

    if @entry.nil?
      flash[:error] = "Entry ID #{params[:id]} does not exist"
      redirect_to(entries_url)
    elsif @entry.update_attributes(params[:entry])
      flash[:success] = 'Entry updated'
      redirect_to(entries_url)
    else
      flash.now[:error] = @entry.errors.full_messages.join('<br>').html_safe
      render :action => :edit
    end
  end


  def destroy
    @entry = Entry.find(params[:id]) if Entry.exists?(params[:id])

    if @entry.nil?
      flash.now[:error] = "Entry ID #{params[:id]} does not exist"
    elsif @entry.destroy
      flash[:success] = 'Entry has been deleted'
    else
      flash.now[:error] = @entry.errors.full_messages.join('<br>').html_safe
    end
    redirect_to(entries_path)
  end

end
