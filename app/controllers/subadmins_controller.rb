class SubadminsController < ApplicationController
  # GET /subadmins
  # GET /subadmins.json
  def index
    @subadmins = Subadmin.paginate(:page => params[:page], :per_page => 1)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subadmins }
    end
  end
  
  def generate_free_code
    @user = User.find_by_id(params[:user_id])
    @free_code = @user.free_codes
    unless @free_code.blank?
      @free_code = @free_code.last.update_attribute(:code , rand(36**10).to_s(36))
      redirect_to subadmins_path
    else
      @free_code = FreeCode.create(:user_id => params[:user_id], :code => rand(36**10).to_s(36))
      redirect_to subadmins_path
    end
  end
  # GET /subadmins/1
  # GET /subadmins/1.json
  def show
    @subadmin = Subadmin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subadmin }
    end
  end

  # GET /subadmins/new
  # GET /subadmins/new.json
  def new
    @subadmin = Subadmin.new

    @users = []
    @usr = User.all
    @usr.each do |usr|
      if usr.usertype == "student"
        @users << usr
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subadmin }
    end
  end

  # GET /subadmins/1/edit
  def edit
    @subadmin = Subadmin.find(params[:id])

    @users = []
    @usr = User.all
    @usr.each do |usr|
      if usr.usertype == "student" || usr.usertype == "subadmin"
        @users << usr
      end
    end

  end

  # POST /subadmins
  # POST /subadmins.json
  def create
    @subadmin = Subadmin.new(params[:subadmin])

    respond_to do |format|
      if @subadmin.save
        format.html { redirect_to @subadmin, notice: 'Subadmin was successfully created.' }
        format.json { render json: @subadmin, status: :created, location: @subadmin }
      else
        format.html { render action: "new" }
        format.json { render json: @subadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /subadmins/1
  # PUT /subadmins/1.json
  def update
    @subadmin = Subadmin.find(params[:id])

    respond_to do |format|
      if @subadmin.update_attributes(params[:subadmin])
        format.html { redirect_to @subadmin, notice: 'Subadmin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subadmin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subadmins/1
  # DELETE /subadmins/1.json
  def destroy
    @subadmin = Subadmin.find(params[:id])
    @subadmin.destroy

    respond_to do |format|
      format.html { redirect_to subadmins_url }
      format.json { head :no_content }
    end
  end
end
