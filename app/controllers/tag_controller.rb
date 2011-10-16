class TagController < ApplicationController
  skip_before_filter :authenticate
  
  def new
  end
  
  def thanks
    render :thanks, :layout => false
  end
end
