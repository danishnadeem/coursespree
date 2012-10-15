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

  def oauth
    #raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:oauth] = true
    session[:user_id] = user.id
    session[:tutor_id] = user.tutor_id if defined? user.tutor_id
    p session
    if Time.now - user.created_at < 30# newly created within 30s
      flash[:notice] = "please complete your profile"
      redirect_to edit_user_url(user)
    else
      redirect_to user
    end 
  end
  
end
