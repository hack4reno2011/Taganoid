class Setting::StatusesController < ApplicationController

  def index
    @search = Status.search(params[:q])
    @search.sorts = 'descr asc' if @search.sorts.empty?
    @statuses = @search.result.paginate(page: params[:page])
  end

  def new
    @status = Status.new
  end

  def edit
    @status = Status.find(params[:id]) if Status.exists?(params[:id])
    unless @status
      flash[:error] = "Status ID #{params[:id]} does not exist"
      redirect_to(setting_statuses_path())
    end
  end


  def create
    @status = Status.new(params[:status])
    if @status.save
      flash[:success] = 'Successfully create Entry Type'
      redirect_to setting_statuses_url
    else
      flash.now[:error] = @status.errors.full_messages.join("<br>").html_safe
      render :action => :new
    end
  end


  def update
    @status = Status.find(params[:id]) if Status.exists?(params[:id])

    if @status.nil?
      flash[:error] = "Status ID #{params[:id]} does not exist"
      redirect_to(setting_statuses_url)
    elsif @status.update_attributes(params[:status])
      flash[:success] = 'Status updated'
      redirect_to(setting_statuses_url)
    else
      flash.now[:error] = @status.errors.full_messages.join('<br>').html_safe
      render :action => :edit
    end
  end


  def destroy
    @status = Status.find(params[:id]) if Status.exists?(params[:id])

    if @status.nil?
      flash.now[:error] = "Status ID #{params[:id]} does not exist"
    elsif @status.use_count == 0 and @status.destroy
      flash[:success] = 'Status has been deleted'
    elsif @status.use_count > 0
      flash.now[:error] = 'Status must not be in use before it can be deleted'
    else
      flash.now[:error] = @status.errors.full_messages.join('<br>').html_safe
    end
    redirect_to(setting_statuses_path)
  end

end
