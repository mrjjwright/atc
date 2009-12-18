class HomeController < ApplicationController
  
  def index
    @media_profile = MediaProfile.last
  end
  
  
  def about
    @about = About.last
  end

  def show
    render :action => params[:page]
  end
  
  
  
end
