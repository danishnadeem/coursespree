class SubjectsTutorsController < ApplicationController
  
  def select
    if !params[:sid].nil? && !session[:user_id].nil?
      tutor_id = Tutor.find_by_user_id(session[:user_id]).id
      @subjects_tutor = SubjectsTutor.new(
        :subject_id => params[:sid],
        :tutor_id => tutor_id
      )
      usubs = User.find(session[:user_id])
      
      respond_to do |format|
        if @subjects_tutor.save
          format.html {redirect_to User.find(session[:user_id])}
        end
      end
    end
  end
  
  # GET /subjects_tutors
  # GET /subjects_tutors.json
  def index
    @subjects_tutors = SubjectsTutor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subjects_tutors }
    end
  end

  # GET /subjects_tutors/1
  # GET /subjects_tutors/1.json
  def show
    @subjects_tutor = SubjectsTutor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subjects_tutor }
    end
  end

  # GET /subjects_tutors/new
  # GET /subjects_tutors/new.json
  def new
    @subjects_tutor = SubjectsTutor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subjects_tutor }
    end
  end

  # GET /subjects_tutors/1/edit
  def edit
    @subjects_tutor = SubjectsTutor.find(params[:id])
  end

  # POST /subjects_tutors
  # POST /subjects_tutors.json
  def create
    @subjects_tutor = SubjectsTutor.new(params[:subjects_tutor])

    respond_to do |format|
      if @subjects_tutor.save
        format.html { redirect_to User.find(session[:user_id]), notice: 'Subjects tutor was successfully created.' }
        format.json { render json: @subjects_tutor, status: :created, location: @subjects_tutor }
      else
        format.html { render action: "new" }
        format.json { render json: @subjects_tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subjects_tutors/1
  # PUT /subjects_tutors/1.json
  def update
    @subjects_tutor = SubjectsTutor.find(params[:id])

    respond_to do |format|
      if @subjects_tutor.update_attributes(params[:subjects_tutor])
        format.html { redirect_to @subjects_tutor, notice: 'Subjects tutor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subjects_tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects_tutors/1
  # DELETE /subjects_tutors/1.json
  def destroy
    @subjects_tutor = SubjectsTutor.find(params[:id])
    @subjects_tutor.destroy

    respond_to do |format|
      format.html {redirect_to User.find(session[:user_id])}
      format.json { head :no_content }
    end
  end
end
