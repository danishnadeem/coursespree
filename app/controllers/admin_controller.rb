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
      if current_user.usertype=="subadmin"
        if trans.user.university == current_user.university
          @trans_subadmin << trans
        end
      else
        @trans << trans
      end
    end
  end

  def search_payments_transactions
    @free_code_user_university=[]
    @free_code_user_university_user=[]
    @trans_free_code=[]
    @free_code = FreeCode.search(params[:search])
    if params[:search].blank?
      redirect_to '/payment_transaction'
    else
      unless @free_code.blank?
        @free_code_user_university << @free_code.last.user.university
        @free_code_user_university_user << @free_code_user_university.last.users
        @free_code_user_university_user.each do |usr|
          @trans_free_code << usr.last.transaction
        end
        @trans_free_code   =  @trans_free_code[0]
        render :show_payments_transactions
      else
        render :show_payments_transactions
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
