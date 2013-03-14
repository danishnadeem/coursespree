class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  
  before_filter :authticate, :except => [:create, :new ,:register, :edit, :show, :update, :fetch_departments]

  def authticate
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in."
      redirect_to :controller => 'admin', :action => 'login'
    else
      unless current_user.usertype=="subadmin" || current_user.usertype=="superadmin"
        flash[:notice] = "you have no access to see the User's Page"
        redirect_to user_path(current_user)
      end
    end
  end
  
  def index
    @users = []
    @subadmin_users = []
    if defined?(params[:uid]) && params[:uid] && params[:uid].length>0
      @uid = params[:uid]
      @users1 = User.find_all_by_university_id(params[:uid])
      @users1.each do |usr|
        if usr.subadmin.blank? && usr.superadmin.blank? && usr.tutor.blank?
          @users << usr
        end
      end

      @users = @users.sort_by { |m| m[:name] }.paginate(:page => params[:page], :per_page => 30)

    else
      @users1 = User.all
      @users1.each do |usr|
        if usr.subadmin.blank? && usr.superadmin.blank? && usr.tutor.blank?
          @users << usr
        end
      end

      @users = @users.sort_by { |m| m[:name] }.paginate(:page => params[:page], :per_page => 30)

      if current_user.usertype=="subadmin"
        Department.all.each do |dept|
          if current_user.department.present? && current_user.department.id == dept.id
            @subadmin_users1 = User.find_all_by_department_id(dept.id)
          end
        end
      end
      
      if  @subadmin_users1.present?
        @subadmin_users1.each do |user|
          if (current_user.usertype == "subadmin" && user.usertype!="superadmin" && user.usertype!="subadmin" && user.tutor.blank?)
            @subadmin_users << user
          end
        end
      end
      
      if @subadmin_users.present?
        @subadmin_users = @subadmin_users.sort_by { |m| m[:name] }.paginate(:page => params[:page], :per_page => 30)
      end
      
      begin
        @univ = University.find(params[:uid]).name
      rescue ActiveRecord::RecordNotFound
        @univ = "no university selected"
      end

      unless params[:search].blank?
        @search = params[:search]
        searched_user = User.search(params[:search])
        searched_user = searched_user.first
        unless searched_user.blank?
          if current_user.present? && current_user.usertype == "superadmin" && searched_user.usertype!="subadmin" && searched_user.usertype!="superadmin" && searched_user.tutor.blank?
            @searched_user = searched_user
          elsif current_user.present? && current_user.usertype == "subadmin" && searched_user.usertype!="subadmin" && searched_user.usertype!="superadmin" && searched_user.tutor.blank?
            if searched_user.department == current_user.department
              @searched_user = searched_user
            end
          end
        end
      end
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @subject = Subject.new
    if @user.usertype == "tutor" && current_user.present? && current_user.usertype == "superadmin"
      session[:tutor_id] = @user.tutor.id
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def fetch_departments
    if params[:university_id].present?
      @university = University.find_by_id(params[:university_id])
      if @university.departments.present?
        @departments = @university.departments
      end
    end
    respond_to do |format|
      format.js do
        departments = render_to_string(:partial => "departments", :locals => {:departments => @departments}).to_json
        render :js => "$('#departments_updated').html(#{departments});"
      end
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
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if !@user.blank? && (@user == current_user || current_user.usertype=="superadmin" || current_user.usertype=="subadmin")
      if current_user.usertype=="subadmin"
        if @user.department == current_user.department
          @departments = @user.university.departments
        else
          redirect_to user_path(current_user)
        end
      elsif @user.university.present?
        @departments = @user.university.departments
      end
    else
      redirect_to user_path(current_user)
    end
  end

  # POST /users
  # POST /users.json
  def create
    #flag to see if user apply to be tutor on registration
    if !params[:user].blank?
      tu = params[:user][:tutor]
      params[:user].delete :tutor
    end
    
    @user = User.new(params[:user])
    puts "888888888888888888888888888"
    puts @user.inspect

    if !params["addUniv"].blank? && !params["newuniv"].blank?
      if params["addUniv"] == "checked" && params["newuniv"].length > 0
        newU = University.find_or_create_by_name(params["newuniv"])
        newU.save!
        @user.university_id = newU.id
        @user.department_id = nil
      end
      if params["addDept"].present? && params["newdept"].length > 0
        newD = Department.find_or_create_by_name(params["newdept"])
        newD.university_id=@user.university_id
        newD.save!
        @user.department_id = newD.id
        # if a new university is selected and old department is already selected then do nothing
        #      elsif params[:department_id].present?
        #        @user.department_id = params[:department_id]
      end
    elsif @user.university_id.present?
      if params["addDept"].present? && params["newdept"].length > 0
        newD = Department.find_or_create_by_name(params["newdept"])
        newD.university_id=@user.university_id
        newD.save!
        @user.department_id = newD.id
      end
    end

    respond_to do |format|
      # if apply to be tutor on registration redirect to tutor application page after registration succeed
      if @user.save && !tu.nil? && tu == "1"
        session[:user_id] = @user.id
        format.html { redirect_to new_tutor_url(:uid => @user.id), notice: 'Please fill application for tutor' }
        format.json { render json: @user, status: :created, location: @user }
      elsif @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'registration succeed, automatically signed in' }
        format.json { render json: @user, status: :created, location: @user}
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
    if !params["addUniv"].blank? && !params["newuniv"].blank?
      if params["addUniv"] == "checked" && params["newuniv"].length > 0
        newU = University.find_or_create_by_name(params["newuniv"])
        newU.save!
        params[:user][:university_id] = newU.id
        params[:user][:department_id] = nil
      end
      if params["addDept"].present? && params["newdept"].length > 0
        newD = Department.find_or_create_by_name(params["newdept"])
        newD.university_id=params[:user][:university_id]
        newD.save!
        params[:user][:department_id] = newD.id

        # if a new university is selected and old department is already selected then do nothing
        #      elsif params[:department_id].present?
        #        @user.department_id = params[:department_id]
      end
    elsif @user.university_id.present?
      if params["addDept"].present? && params["newdept"].length > 0
        newD = Department.find_or_create_by_name(params["newdept"])
        newD.university_id=@user.university_id
        newD.save!
        params[:user][:department_id] = newD.id
      end
    end
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
    if @user.id == session[:user_id]
      reset_session
    end
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
