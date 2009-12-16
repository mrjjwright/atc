class HomeController < ApplicationController
  
  def index
    @media_profile = MediaProfile.last
    if @media_profile.nil? then
      @media_profile = MediaProfile.new
      @media_profile.title = 'Rob Coppolillo - Goin Heavy'
      @media_profile.link = 'http://photos-a.ak.fbcdn.net/hphotos-ak-snc3/hs052.snc3/13937_376548240234_331358835234_10291186_1926195_n.jpg'
      @media_profile.save
    end
  end

  def show
    render :action => params[:page]
  end
  
end
