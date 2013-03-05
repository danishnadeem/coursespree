class TutorAvailabilitiesController < ApplicationController
  # GET /tutor_availabilities
  # GET /tutor_availabilities.json
  def index
    if session[:tutor_id].present?
      @tutor_availabilities = TutorAvailability.find(:all, :conditions => ["tutor_id = ? AND start_time >= ?", session[:tutor_id], Time.now])
    else
      @tutor_availabilities = TutorAvailability.find(:all, :conditions => ["tutor_id = ? AND start_time >= ?", params[:tutor_id], Time.now])
    end
    @tutor_availability = TutorAvailability.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutor_availabilities }
    end
  end

  # GET /tutor_availabilities/1
  # GET /tutor_availabilities/1.json
  def show
    @tutor_availability = TutorAvailability.find(params[:id])

    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutor_availability }
    end
  end

  # GET /tutor_availabilities/new
  # GET /tutor_availabilities/new.json
  def new
    @tutor_availability = TutorAvailability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutor_availability }
    end
  end

  # GET /tutor_availabilities/1/edit
  def edit
    @tutor_availability = TutorAvailability.find(params[:id])
  end

  # POST /tutor_availabilities
  # POST /tutor_availabilities.json
  def create
    cnt = params[:tutor_availability][:repeat].to_i - 1
    params[:tutor_availability].delete :repeat
    @tutor_availability = TutorAvailability.new(params[:tutor_availability])

    respond_to do |format|
      if @tutor_availability.save
        if cnt > 0
          for i in 1..cnt
            new_ta = TutorAvailability.new(params[:tutor_availability])
            new_ta.start_time = @tutor_availability.start_time + 604800*i
            new_ta.save
          end
        end
        if params[:tutor_availability][:tutor_id].present?
          tutor_id = params[:tutor_availability][:tutor_id]
          format.html { redirect_to tutor_availabilities_path(:tutor_id=>tutor_id), notice: 'Tutor availability was successfully created.' }
          format.json { render json: @tutor_availability, status: :created, location: @tutor_availability }
        else
          format.html { redirect_to tutor_availabilities_path, notice: 'Tutor availability was successfully created.' }
          format.json { render json: @tutor_availability, status: :created, location: @tutor_availability }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @tutor_availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutor_availabilities/1
  # PUT /tutor_availabilities/1.json
  def update
    @tutor_availability = TutorAvailability.find(params[:id])

    respond_to do |format|
      if @tutor_availability.update_attributes(params[:tutor_availability])
        if params[:tutor_availability][:tutor_id].present?
          tutor_id = params[:tutor_availability][:tutor_id]
          format.html { redirect_to tutor_availabilities_path(:tutor_id=>tutor_id), notice: 'Tutor availability was successfully created.' }
          format.json { render json: @tutor_availability, status: :created, location: @tutor_availability }
        else
          format.html { redirect_to @tutor_availability, notice: 'Tutor availability was successfully updated.' }
          format.json { head :no_content }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @tutor_availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutor_availabilities/1
  # DELETE /tutor_availabilities/1.json
  def destroy
    @tutor_availability = TutorAvailability.find(params[:id])
    @tutor_availability.destroy

    respond_to do |format|
      format.html { redirect_to tutor_availabilities_url }
      format.json { head :no_content }
    end
  end
end
