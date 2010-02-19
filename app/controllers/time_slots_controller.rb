class TimeSlotsController < ApplicationController
  # GET /time_slots
  # GET /time_slots.xml
  
  def index
    @time_slots = TimeSlot.all if (params[:week_of].nil?)
    @time_slots = TimeSlot.on_week(params[:week_of]) unless (params[:week_of].nil?)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @time_slots }
      format.js  { render :json => @time_slots }
    end
  end

  # GET /time_slots/1
  # GET /time_slots/1.xml
  def show
    @time_slot = TimeSlot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @time_slot }
    end
  end

  # GET /time_slots/new
  # GET /time_slots/new.xml
  def new
    @time_slot = TimeSlot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @time_slot }
    end
  end

  # GET /time_slots/1/edit
  def edit
    @time_slot = TimeSlot.find(params[:id])
  end

  # POST /time_slots
  # POST /time_slots.xml
  def create
    @time_slot = TimeSlot.new
    @time_slot.week_of = params[:week_of]
    @time_slot.full_name = params[:full_name]
    @time_slot.workout_type = params[:workout_type]
    @time_slot.time_slot = params[:time_slot]
    

    respond_to do |format|
      if @time_slot.save
        flash[:notice] = 'TimeSlot was successfully created.'
        format.html { redirect_to(@time_slot) }
        format.xml  { render :xml => @time_slot, :status => :created, :location => @time_slot }
        format.js {render :json => "Success"}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @time_slot.errors, :status => :unprocessable_entity }
        format.js {render :json => @time_slot.errors.full_messages[0]}
      end
    end
  end

  # PUT /time_slots/1
  # PUT /time_slots/1.xml
  def update
    @time_slot = TimeSlot.find(params[:id])

    respond_to do |format|
      if @time_slot.update_attributes(params[:time_slot])
        flash[:notice] = 'TimeSlot was successfully updated.'
        format.html { redirect_to(@time_slot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @time_slot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_slots/1
  # DELETE /time_slots/1.xml
  def destroy
    @time_slot = TimeSlot.find(params[:id])
    @time_slot.destroy

    respond_to do |format|
      format.html { redirect_to(time_slots_url) }
      format.xml  { head :ok }
    end
  end
end
