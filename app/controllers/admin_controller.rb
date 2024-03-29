class AdminController < ApplicationController
  def login
    if request.post?
      @usnm = params[:username]
      @pswd=  params[:password]
      user = User.authenticate(params[:username], params[:password])
      if user
        if user.usertype == 'tutor' || user.usertype == 'tem_tutor'
          session[:tutor_id] = user.tutor.id
        end
        session[:user_id] = user.id
        session[:username] = user.username
        redirect_to user
      else
        flash.now[:notice] = "Invalid login credential" 
      end
    elsif request.get? && !session[:user_id].nil?
      redirect_to tutors_path
      flash[:notice] = "You already logged in"
    end
  end

  def logout
    reset_session
    flash[:notice] = "Logged Out"
    redirect_to(:action => "login")
  end

  def show_payments_transactions
    @trans_subadmin=[]
    @trans=[]
    @transaction = Transaction.all
    @transaction.each do |trans|
      if current_user.present? && current_user.usertype=="subadmin"
        if current_user.department.present? && trans.tutor.user.department.present? && trans.tutor.user.department == current_user.department && trans.meeting.has_code == false
          @trans_subadmin << trans
        end
      else
        @trans << trans
      end
    end

    if @trans_subadmin.present?
      @trans_subadmin = @trans_subadmin.paginate(:page => params[:page], :per_page => 30)
    end

    if @trans.present?
      @trans = @trans.paginate(:page => params[:page], :per_page => 30)
    end
  end

  def search_payments_transactions

    #    @free_code_user_university=[]
    #    @free_code_user_university_user=[]
    @trans_free_code=[]
    @trans_free_code_arr=[]
    @search = params[:search]
    @free_code = User.find_by_id(params[:search])
    if params[:search].blank?
      redirect_to '/payment_transaction'
    else
      unless @free_code.blank?
        @free_code_user_university = @free_code.department
        @free_code_user_university_user = @free_code_user_university.users

        @free_code_user_university_user.each do |user_one_by_one|
          @trans_free_code_arr << user_one_by_one.transactions
          @trans_free_code_arr.each do |trans|
            unless trans.blank?  
              @trans_free_code << trans              
            end
          end
          
          if @trans_free_code.present?
            tmp = []
            tmp = @trans_free_code.first
            @trans_free_code = tmp.paginate(:page => params[:page], :per_page => 30)
          end
        end

        render :show_payments_transactions
      else
        render :show_payments_transactions
      end
    end
  end

  def search_payments_transactions_1
    @free_code_user_university=[]
    @free_code_user_university_user=[]
    @trans_free_code=[]
    @trans_free_code_arr=[]
    @free_code = FreeCode.search(params[:search])
    if params[:search].blank?
      redirect_to '/payment_transaction'
    else
      unless @free_code.blank?
        @free_code_user_university << @free_code.last.user.department
        @free_code_user_university_user << @free_code_user_university.last.users

        @free_code_user_university_user.each do |usr|
          usr.each do |user_one_by_one|
            #            puts "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
            #            puts user_one_by_one.transaction.inspect
            @trans_free_code_arr << user_one_by_one.transaction
          end
          @trans_free_code_arr.each do |trans|
            unless trans.blank?
              puts "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
              puts trans.inspect
              @trans_free_code << trans
            end
          end

          #          @trans_free_code << usr.last.transaction
          #          puts "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
          #          puts @trans_free_code.inspect
          #          aaaaaa
        end

        #        @trans_free_code   =  @trans_free_code[0]
        render :show_payments_transactions
      else
        render :show_payments_transactions
      end
    end
  end

  def show_student_meetings_reports
    #    all_users = User.all
    #    @users = []
    #    if current_user.usertype=="superadmin"
    #      all_users.each do |usr|
    #        if usr.tutor.blank? && usr.usertype!="superadmin" && usr.usertype!="subadmin"
    #          @users << usr
    #        end
    #      end
    #    elsif current_user.usertype=="subadmin"
    #      all_users.each do |usr|
    #        if usr.tutor.blank? && usr.usertype!="superadmin" && usr.usertype!="subadmin"
    #          if usr.university == current_user.university
    #            @users << usr
    #          end
    #        end
    #      end
    #    end
    #
    #    @users_meetings = []
    #    @users.each do |usr|
    #      if usr.meetings.present?
    #        usr.meetings.each do |meeting|
    #          @users_meetings << meeting
    #        end
    #      end
    #    end
  end

  def search_student_meetings_reports
    @searched_user_meetings = []
    @search = params[:search]
    searched_user = User.search(params[:search])
    if params[:search].blank?
      redirect_to '/student_report'
    else
      unless searched_user.blank?
        if searched_user.first.tutor.blank? && current_user.present? && current_user.usertype!="subadmin"
          searched_user.first.meetings.each do |m|
            @searched_user_meetings << m
          end
        elsif searched_user.first.tutor.blank? && current_user.present? && current_user.usertype=="subadmin"
          if searched_user.first.department.present? && current_user.present? && current_user.department.present? && searched_user.first.department.id == current_user.department.id
            if searched_user.first.meetings.present?
              searched_user.first.meetings.each do |m|
                @searched_user_meetings << m
              end
            end
          end
        end
        
        if @searched_user_meetings.present?
          @searched_user_meetings = @searched_user_meetings.paginate(:page => params[:page], :per_page => 30)
        end
        
        render :show_student_meetings_reports
      else
        render :show_student_meetings_reports
      end
    end
  end

  def show_tutor_meetings_reports

  end

  def search_tutor_meetings_reports
    @searched_user_meetings = []
    @search = params[:search]
    searched_user = User.search(params[:search])
    if params[:search].blank?
      redirect_to '/tutor_report'
    else
      unless searched_user.blank?
        if searched_user.first.tutor.present? && current_user.present? && current_user.usertype!="subadmin"
          if searched_user.first.tutor.meetings.present?
            searched_user.first.tutor.meetings.each do |m|
              @searched_user_meetings << m
            end
          end
        elsif searched_user.first.tutor.present? && current_user.present? && current_user.usertype=="subadmin"
          if searched_user.first.department.present? && current_user.present? && current_user.department.present? && searched_user.first.department.id == current_user.department.id
            searched_user.first.tutor.meetings.each do |m|
              @searched_user_meetings << m
            end
          end
        end

        if @searched_user_meetings.present?
          @searched_user_meetings = @searched_user_meetings.paginate(:page => params[:page], :per_page => 30)
        end

        render :show_tutor_meetings_reports
      else
        render :show_tutor_meetings_reports
      end
    end
  end

  def oauth
    #raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:oauth] = true
    session[:user_id] = user.id
    session[:username] = user.username
    session[:tutor_id] = user.tutor.id if Tutor.find_by_user_id(user.id)
    if Time.now - user.created_at < 30# newly created within 30s
      flash[:notice] = "please complete your profile"
      redirect_to edit_user_url(user)
    else
      redirect_to user
    end
  end
  
end
