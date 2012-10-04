class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authticate, :except => ["login","index","show"]
  
  def authticate
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in."
      redirect_to :controller => 'admin', :action => 'login'
    end    
  end
  
  def current_user
    if defined? session[:user_id] && !session[:user_id].nil?
      User.find session[:user_id]
    end
  end
  
  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end
end
