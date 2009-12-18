class HomeController < ApplicationController
  
  def index
    @media_profile = MediaProfile.last
  end
  
  def index_edit
    @media_profile = MediaProfile.last
  end
  

  def show
    render :action => params[:page]
  end
  
  
  
end
