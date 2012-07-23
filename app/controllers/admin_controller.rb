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
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "Logged Out"
    redirect_to(:action => "login")
  end
  
end
