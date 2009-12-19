class HomeController < ApplicationController
  
  def index
    @media_profile = MediaProfile.first
      if @media_profile.nil? then
        @media_profile = MediaProfile.new
        @media_profile.save
      end
    
  end
  
  
  def about
    @about = About.first
     if @about.nil? then
          @about = About.new
          @about.save
      end
  end

  def training
    @workouts = Workout.all
  end
  
  def show
    render :action => params[:page]
  end
  
  
  
end
