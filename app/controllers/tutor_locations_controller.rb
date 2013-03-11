class TutorLocationsController < ApplicationController
  # GET /tutor_locations
  # GET /tutor_locations.json
  def index
    @tutor_locations = TutorLocation.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutor_locations }
    end
  end

  # GET /tutor_locations/1
  # GET /tutor_locations/1.json
  def show
    @tutor_location = TutorLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutor_location }
    end
  end

  # GET /tutor_locations/new
  # GET /tutor_locations/new.json
  def new
    @tutor_location = TutorLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutor_location }
    end
  end

  # GET /tutor_locations/1/edit
  def edit
    @tutor_location = TutorLocation.find(params[:id])
  end

  # POST /tutor_locations
  # POST /tutor_locations.json
  def create
    @tutor_location = TutorLocation.new(params[:tutor_location])

    respond_to do |format|
      if @tutor_location.save
        format.html { redirect_to @tutor_location, notice: 'Tutor location was successfully created.' }
        format.json { render json: @tutor_location, status: :created, location: @tutor_location }
      else
        format.html { render action: "new" }
        format.json { render json: @tutor_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutor_locations/1
  # PUT /tutor_locations/1.json
  def update
    @tutor_location = TutorLocation.find(params[:id])

    respond_to do |format|
      if @tutor_location.update_attributes(params[:tutor_location])
        format.html { redirect_to @tutor_location, notice: 'Tutor location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutor_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutor_locations/1
  # DELETE /tutor_locations/1.json
  def destroy
    @tutor_location = TutorLocation.find(params[:id])
    @tutor_location.destroy

    respond_to do |format|
      format.html { redirect_to tutor_locations_url }
      format.json { head :no_content }
    end
  end
end
