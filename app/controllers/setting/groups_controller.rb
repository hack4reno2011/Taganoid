class Setting::GroupsController < ApplicationController

  def index
    @search = Group.search(params[:q])
    @search.sorts = 'descr asc' if @search.sorts.empty?
    @groups = @search.result.paginate(page: params[:page])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id]) if Group.exists?(params[:id])
    unless @group
      flash[:error] = "Group ID #{params[:id]} does not exist"
      redirect_to(setting_groups_path())
    end
  end


  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = 'Successfully create Entry Type'
      redirect_to setting_groups_url
    else
      flash.now[:error] = @group.errors.full_messages.join("<br>").html_safe
      render :action => :new
    end
  end


  def update
    @group = Group.find(params[:id]) if Group.exists?(params[:id])

    if @group.nil?
      flash[:error] = "Group ID #{params[:id]} does not exist"
      redirect_to(setting_groups_url)
    elsif @group.update_attributes(params[:group])
      flash[:success] = 'Group updated'
      redirect_to(setting_groups_url)
    else
      flash.now[:error] = @group.errors.full_messages.join('<br>').html_safe
      render :action => :edit
    end
  end


  def destroy
    @group = Group.find(params[:id]) if Group.exists?(params[:id])

    if @group.nil?
      flash.now[:error] = "Group ID #{params[:id]} does not exist"
    elsif @group.use_count == 0 and @group.destroy
      flash[:success] = 'Group has been deleted'
    elsif @group.use_count > 0
      flash.now[:error] = 'Group must not be in use before it can be deleted'
    else
      flash.now[:error] = @group.errors.full_messages.join('<br>').html_safe
    end
    redirect_to(setting_groups_path)
  end

end
