class AthletesController < ApplicationController
  # GET /athletes
  # GET /athletes.xml
  def index
    @athletes = Athlete.find(:all, :order => 'name')

    respond_to do |format|
      format.html { render :layout => 'application'} # index.html.erb
      format.xml  { render :xml => @athletes }
    end
  end


  def index_admin
    @athletes = Athlete.find(:all, :order => 'name')

    respond_to do |format|
      format.html {render :tempate => 'athletes/index_admin', :layout => 'application'}# index.html.erb
      format.xml  { render :xml => @athletes }
    end
  end


  # GET /athletes/1
  # GET /athletes/1.xml
  def show
    @athlete = Athlete.find(params[:id])
    
    #check to see if this user has a fb uid
    @athlete.check_for_fb_uid
    
    # if the user is a fb_user then let's load the photos they are tagged in
    if @athlete.fb_uid? then
      fb = Facebook.new
      photos = fb.photos_tagged_user(@athlete.fb_uid)
      @fb_photos = photos if photos.size > 0
    end
    
    respond_to do |format|
      format.html { render :layout => 'application'} # show.html.erb
      format.xml  { render :xml => @athlete }
    end
  end

  # GET /athletes/new
  # GET /athletes/new.xml
  def new
    @athlete = Athlete.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @athlete }
    end
  end

  # GET /athletes/1/edit
  def edit
    @athlete = Athlete.find(params[:id])
 
    respond_to do |format|
       format.html { render :layout => 'application'}
     end
  end

  # POST /athletes
  # POST /athletes.xml
  def create
    @athlete = Athlete.new(params[:athlete])

    respond_to do |format|
      if @athlete.save
        flash[:notice] = 'Athlete was successfully created.'
        format.html { redirect_to(@athlete) }
        format.xml  { render :xml => @athlete, :status => :created, :location => @athlete }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @athlete.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /athletes/1
  # PUT /athletes/1.xml
  def update
    @athlete = Athlete.find(params[:id])

    if (params[:secret_key].nil?) then
      @athlete.errors.add(:base, "Missing secret key")
      render :action => "edit", :layout => 'application'
      return
    end

    if (params[:secret_key] != ATC_SECRET_KEY) 
      @athlete.errors.add(:base, "Invalid secret key")
      render :action => "edit", :layout => 'application'
      return
    end

    respond_to do |format|
      if @athlete.update_attributes(params[:athlete])
        flash[:notice] = 'Athlete was successfully updated.'
        format.html { redirect_to(@athlete) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @athlete.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /athletes/1
  # DELETE /athletes/1.xml
  def destroy
    
    @athlete = Athlete.find(params[:id])

    if (params[:prompt_reply].nil?) then
      @athlete.errors.add(:base, "Missing secret key")
      @athletes = Athlete.find(:all, :order => 'name')
      render :action => "index_admin", :layout => 'application'
      return
    end
    
    if (params[:prompt_reply] != ATC_SECRET_KEY) 
      @athlete.errors.add(:base, "Invalid secret key")
       @athletes = Athlete.find(:all, :order => 'name')
       render :action => "index_admin", :layout => 'application'
       return
    end
    

    @athlete.destroy
  

    respond_to do |format|
      format.html { redirect_to(athletes_url) }
      format.xml  { head :ok }
    end
  end
end
