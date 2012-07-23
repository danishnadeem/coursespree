class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  before_filter :authticate, :except => [:create, :register]
  
  def authticate
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in."
      redirect_to :controller => 'admin', :action => 'login'
    end    
  end  

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @subject = Subject.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def register
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    #flag to see if user apply to be tutor on registration
    tu = params[:user][:tutor]
    
    params[:user].delete :tutor
    @user = User.new(params[:user])
    
    respond_to do |format|
      # if apply to be tutor on registration redirect to tutor application page after registration succeed
      if @user.save && !tu.nil? && tu == "1"
        session[:user_id] = @user.id
        format.html { redirect_to new_tutor_url(:uid => @user.id), notice: 'Please fill application for tutor' }
        format.json { render json: @user, status: :created, location: @user }
      elsif @user.save && !tu.nil? && tu == "0"
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'registration succeed, automatically signed in' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "register" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
