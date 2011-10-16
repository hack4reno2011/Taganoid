require 'base64'
require 'paperclip/upfile' # for StringIO monkey patch

class EntriesController < ApplicationController

  skip_before_filter  :authenticate,
                      :only => [ :new, :create ]

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

    create_image_from_base64

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
    elsif @entry.use_count == 0 and @entry.destroy
      flash[:success] = 'Entry has been deleted'
    elsif @entry.use_count > 0
      flash.now[:error] = 'Entry must not be in use before it can be deleted'
    else
      flash.now[:error] = @entry.errors.full_messages.join('<br>').html_safe
    end
    redirect_to(entries_path)
  end

  protected

    # workaround difficulty uploading from iphone (sencha)
    #
    def create_image_from_base64
      if params[:image_base64]
        sio = StringIO.new(Base64.decode64(params[:image_base64]))
        sio.content_type = "image/jpeg"
        sio.original_filename = "mobile-photo.jpg"
        @entry.photo = sio
      end
    end

end
