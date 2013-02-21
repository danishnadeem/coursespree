class TutorsController < ApplicationController
  
  # GET /tutors
  # GET /tutors.json
  def index
    # tutor search function documentation
    # 07/19/2012 by Bin
      
    # search based on subject title
    # result excluded un approved tutors
    # tutor self excluded from result

    
    if !params[:subject].nil? && params[:subject].size > 0
      @tutors = Array.new
      subjects = Subject.find(:all, :conditions => ['title LIKE ?', '%' + params[:subject] + '%' ])
      #find all matching subjects
            
      if subjects.count >0 
        @matches = Array.new
        subjects.each do |sub|
          @matches.push(sub.title)
          # for each subject, look for tutors in the bridge table
          # not sure about the find all tutor within selected subject
          subtuts = SubjectsTutor.find_all_by_subject_id(sub.id)
          
          subtuts.each do |st|
          
            tut = Tutor.find(:first, :conditions => ['id = ? AND approved = ?', st.tutor_id, 1])
            if tut && !@tutors.include?(tut)
              @tutors.push(tut)
            end#end if reducing duplicate
          end#end subtuts bridge table.each
        end#end subs.each
      end#end if sub.count>0
      
      
    else #if no matching subject found
      @tutors = Tutor.find(:all, :conditions => ["approved = ?", 1], :limit => 3)
    end
    
    #remove self if current user is tutor
    if Tutor.find_by_user_id(session[:user_id])
      crt_tutor = Tutor.find_by_user_id(session[:user_id])
      @tutors.delete_if{|x| x.id == crt_tutor.id}# remove self being searched
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutors }
    end
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/new
  # GET /tutors/new.json
  def new
    user = User.find(session[:user_id])
    if user.usertype != 'student'
      redirect_to :action => 'edit', :id=> user.tutor.id
      return
    end

    @tutor = Tutor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/1/edit
  def edit
    @tutor = Tutor.find(params[:id])
  end

  # POST /tutors
  # POST /tutors.json
  def create
    unless params[:tutor][:user_id].blank?
      @user = User.find_by_id(params[:tutor][:user_id])
      unless params[:university_id].blank?
        @user.update_attribute(:university_id => params[:university_id])
      end
      unless params[:department_id].blank?
        @user.update_attribute(:department_id => params[:department_id])
      end
    end

    @tutor = Tutor.new(params[:tutor])

    respond_to do |format|
      if @tutor.save
        format.html { redirect_to @tutor, notice: 'Tutor was successfully created.' }
        format.json { render json: @tutor, status: :created, location: @tutor }
      else
        format.html { render action: "new" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutors/1
  # PUT /tutors/1.json
  def update
    @tutor = Tutor.find(params[:id])
    params[:tutor].delete :user_id
    params[:tutor].delete :approved
    respond_to do |format|
      if @tutor.update_attributes(params[:tutor])
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy

    respond_to do |format|
      format.html { redirect_to tutors_url }
      format.json { head :no_content }
    end
  end
  
  def mgmt
    
    @tutors = Tutor.find_all_by_approved(0)
    #session[:pendtut_cnt] = @tutors.count
    if params[:type] == 'pending'
      if @tutors.count <1
        redirect_to :action =>'mgmt', :type => 'current'
      end
    elsif params[:type] == 'current'
      @tutors = Tutor.find_all_by_approved(1)
    else
      @tutors = Tutor.all
    end

    @subadmin_tutors = []
    if current_user.usertype=="subadmin"
      University.all.each do |univ|
        if current_user.university.id == univ.id
          @subadmin_users = User.find_all_by_university_id(univ.id)
        end
      end
      @subadmin_users.each do |subadmin_usr|
        if subadmin_usr.tutor
          @subadmin_tutors << subadmin_usr.tutor
        end
      end
    end
  end
  
  def approve
    if !params[:tid].nil?
      tutor = Tutor.find(params[:tid])
      if tutor.approved = 0
        tutor.approved = 1
      end
    
      if tutor.save
        redirect_to(:back)
      end
    end
  end
  
  def addtutor
    unless params[:from_add_user_as_tutor].blank?
      @from_add_user_as_tutor = params[:from_add_user_as_tutor]
    end

    unless params[:user_id].blank?
      @user_id = params[:user_id]
    end
    @users = []
    all_users = User.all

    if current_user.usertype=="superadmin"
      all_users.each do |usr|
        if usr.tutor.blank? && usr.usertype!="superadmin" && usr.usertype!="subadmin"
          @users << usr
        end
      end
    elsif current_user.usertype=="subadmin"
      all_users = User.all
      all_users.each do |usr|
        if usr.tutor.blank? && usr.usertype!="superadmin" && usr.usertype!="subadmin"
          if usr.university == current_user.university
            @users << usr
          end
        end
      end
    end
    @tutor = Tutor.new
    
    if request.post?
    end
  end
  
end
