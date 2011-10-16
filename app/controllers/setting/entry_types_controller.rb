class Setting::EntryTypesController < ApplicationController

  def index
    @search = EntryType.search(params[:q])
    @search.sorts = 'descr asc' if @search.sorts.empty?
    @entry_types = @search.result.paginate(page: params[:page])
  end

  def new
    @entry_type = EntryType.new
  end

  def edit
    @entry_type = EntryType.find(params[:id]) if EntryType.exists?(params[:id])
    unless @entry_type
      flash[:error] = "Entry type ID #{params[:id]} does not exist"
      redirect_to(setting_entry_types_path())
    end
  end


  def create
    @entry_type = EntryType.new(params[:entry_type])
    if @entry_type.save
      flash[:success] = 'Successfully create Entry Type'
      redirect_to setting_entry_types_url
    else
      flash.now[:error] = @entry_type.errors.full_messages.join("<br>").html_safe
      render :action => :new
    end
  end


  def update
    @entry_type = EntryType.find(params[:id]) if EntryType.exists?(params[:id])

    if @entry_type.nil?
      flash[:error] = "Entry type ID #{params[:id]} does not exist"
      redirect_to(setting_entry_types_url)
    elsif @entry_type.update_attributes(params[:entry_type])
      flash[:success] = 'Entry type updated'
      redirect_to(setting_entry_types_url)
    else
      flash.now[:error] = @entry_type.errors.full_messages.join('<br>').html_safe
      render :action => :edit
    end
  end


  def destroy
    @entry_type = EntryType.find(params[:id]) if EntryType.exists?(params[:id])

    if @entry_type.nil?
      flash.now[:error] = "Entry type ID #{params[:id]} does not exist"
    elsif @entry_type.use_count == 0 and @entry_type.destroy
      flash[:success] = 'Entry type has been deleted'
    elsif @entry_type.use_count > 0
      flash.now[:error] = 'Entry type must not be in use before it can be deleted'
    else
      flash.now[:error] = @entry_type.errors.full_messages.join('<br>').html_safe
    end
    redirect_to(setting_entry_types_path)
  end

end
