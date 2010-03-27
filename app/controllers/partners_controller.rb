class PartnersController < ApplicationController
  # GET /partners
  # GET /partners.xml
  def index
    @partners = Partner.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @partners }
    end
  end

  # GET /partners/1
  # GET /partners/1.xml
  def show
    @partner = Partner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @partner }
    end
  end

  # GET /partners/new
  # GET /partners/new.xml
  def new
    @partner = Partner.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @partner }
    end
  end

  # GET /partners/1/edit
  def edit
    @partner = Partner.last
    if @partner.nil? then
        @partner = partner.new
        @partner.save
    end
    
    respond_to do |format|
      format.html { render  :template => 'partners/edit', :layout => 'application'}
    end
  end

  # POST /partners
  # POST /partners.xml
  def create
    @partner = Partner.new(params[:partner])

    respond_to do |format|
      if @partner.save
        flash[:notice] = 'Partner was successfully created.'
        format.html { redirect_to(@partner) }
        format.xml  { render :xml => @partner, :status => :created, :location => @partner }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @partner.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /partners/1
  # PUT /partners/1.xml
  def update
    @partner = Partner.find(params[:id])

    if (params[:secret_key].nil?) then
      @partner.errors.add(:base, "Missing secret key")
      render :action => "edit", :layout => 'application'
      return
    end
    
    if (params[:secret_key] != ATC_SECRET_KEY) 
      @partner.errors.add(:base, "Wrong secret key")
      render :action => "edit", :layout => 'application'
      return
    end
    
    respond_to do |format|
      if @partner.update_attributes(params[:partner])
        flash[:notice] = 'Partner was successfully updated.'
        format.html { redirect_to("/partners") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @partners.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /partners/1
  # DELETE /partners/1.xml
  def destroy
    @partner = Partner.find(params[:id])
    @partner.destroy

    respond_to do |format|
      format.html { redirect_to(partners_url) }
      format.xml  { head :ok }
    end
  end
end
