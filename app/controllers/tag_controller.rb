class TagController < ApplicationController
  skip_before_filter :authenticate
  
  # def new
  # end
  
  def create
    begin
      @entry = Entry.new(params[:entry])

      create_image_from_base64

      if @entry.save
        render :json => {:success => true}
      else
        render :json => {:error => @entry.errors.full_messages}      
      end
    
    rescue      
      render :json => {:error => $!.message}  
    end
  end
  
  # def thanks
  #   render :thanks, :layout => false
  # end
  
  
  protected

  # workaround difficulty uploading from iphone (sencha)
  #
  def create_image_from_base64
    if params[:entry] && params[:entry][:image_base64]
      sio = StringIO.new(Base64.decode64(params[:entry][:image_base64]))
      sio.content_type = "image/jpeg"
      sio.original_filename = "mobile-photo.jpg"
      @entry.photo = sio
    end
  end
    
    
end
