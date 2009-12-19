class HomeController < ApplicationController
  
  def index
    @media_profile = MediaProfile.first
  end
  
  
  def about
    @about = About.first
  end

  def training
    @workouts = Workout.all
  end
  
  def show
    render :action => params[:page]
  end
  
  
  
end
