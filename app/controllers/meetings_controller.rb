class MeetingsController < ApplicationController
  
  def bbb_api_base_url
    "http://198.101.200.137/bigbluebutton/api/"
  end
  
  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end
  
  # GET /meetings
  # GET /meetings.json
  def index
    if params[:type]=='requested'
      @meetings = Meeting.find_all_by_user_id(session[:user_id])
    elsif params[:type]=='pending'
      @meetings = Meeting.find(:all, :conditions=> ["tutor_id = ? and accept =?", Tutor.find_by_user_id(session[:user_id]).id, 0])
    elsif params[:type]=='past'
      @meetings = Meeting.find(:all, :conditions=> ["tutor_id = ? and accept =?", session[:user_id], 1])
    else
      @meetings = Meeting.all
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @meetings }
    end
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
    @meeting = Meeting.find(params[:id])
    if !params[:accept].nil? && params[:accept] == '1'
      @meeting.accept = 1
      @meeting.save
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/new
  # GET /meetings/new.json
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @meeting }
    end
  end

  # GET /meetings/1/edit
  def edit
    @meeting = Meeting.find(params[:id])
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(params[:meeting])
    @meeting.attendeePW = rand(36**20).to_s(36)
    @meeting.moderatorPW = rand(36**20).to_s(36)
    @meeting.user_id = session[:user_id]
    @meeting.name = @meeting.subject + Time.now.strftime('%y%m%d%h%m%s')

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render json: @meeting, status: :created, location: @meeting }
      else
        format.html { render action: "new" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meetings/1
  # PUT /meetings/1.json
  def update
    @meeting = Meeting.find(params[:id])

    
    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
      format.json { head :no_content }
    end
  end
end
