class MediaProfilesController < ApplicationController
  # GET /media_profiles
  # GET /media_profiles.xml
  def index
    @media_profiles = MediaProfile.all

    respond_to do |format|
      format.html {render :tempate => 'media_profiles/index', :layout => 'application'}
      format.xml  { render :xml => @media_profiles }
    end
  end

  # GET /media_profiles/1
  # GET /media_profiles/1.xml
  def show
    @media_profile = MediaProfile.find(params[:id])

    respond_to do |format|
      format.html { render :template => 'media_profiles/show', :layout => 'application'}
      format.xml  { render :xml => @media_profile }
    end
  end
  
  # GET /media_profiles/new
  # GET /media_profiles/new.xml
  def new
    @media_profile = MediaProfile.new

    respond_to do |format|
      format.html { render :template => 'media_profiles/new', :layout => 'application'}
      format.xml  { render :xml => @media_profile }
    end
  end

  def edit
    @media_profile = MediaProfile.find(params[:id])
    respond_to do |format|
      format.html { render :template => 'media_profiles/edit', :layout => 'application'}
    end
    
  end

  # GET /media_profiles/1/edit
  def edit_last
    @media_profile = MediaProfile.last
    if @media_profile.nil? then
      @media_profile = MediaProfile.new
      @media_profile.save
    end
      
    respond_to do |format|
      format.html { render :template => 'media_profiles/edit', :layout => 'application'}
    end
    
  end

  # POST /media_profiles
  # POST /media_profiles.xml
  def create
    @media_profile = MediaProfile.new(params[:media_profile])

    respond_to do |format|
      if @media_profile.save
        flash[:notice] = 'MediaProfile was successfully created.'
        format.html { redirect_to(@media_profile) }
        format.xml  { render :xml => @media_profile, :status => :created, :location => @media_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @media_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /media_profiles/1
  # PUT /media_profiles/1.xml
  def update

    @media_profile = MediaProfile.find(params[:id])

    if (params[:secret_key].nil?) then
      @media_profile.errors.add(:base, "Missing secret key")
      render :action => "edit", :layout => 'application' 
      return
    end
    
    if (params[:secret_key] != ATC_SECRET_KEY) 
      @media_profile.errors.add(:base, "Wrong secret key")
      render :action => "edit", :layout => 'application'
      return
    end

    respond_to do |format|
      if @media_profile.update_attributes(params[:media_profile])
        flash[:notice] = 'MediaProfile was successfully updated.'
        format.html { redirect_to(@media_profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @media_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /media_profiles/1
  # DELETE /media_profiles/1.xml
  def destroy
    @media_profile = MediaProfile.find(params[:id])
    @media_profile.destroy

    respond_to do |format|
      format.html { redirect_to(media_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
