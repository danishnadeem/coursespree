module ApplicationHelper
  
  def current_user
    if !session[:user_id].nil?
      User.find(session[:user_id])
    end
  end
  
  def bbb_api_base_url
    "http://198.101.200.137/bigbluebutton/api/"
  end
  
  def sha1(string)
    Digest::SHA1.hexdigest(string)
  end
  
  def username
    user = User.find(session[:user_id])
    link_to user.username, user
  end
  
  def logout
    link_to 'logout', '/admin/logout'
  end
  
  def register
    link_to 'register', '/users/register'
  end
  
  def login
    link_to 'login', '/admin/login'
  end
  
  def tuapply
    if !session[:user_id].nil?
      link_to 'apply for tutor', new_tutor_url(:uid => session[:user_id])
    end
    
  end
  
  
  def authlink
    if !session[:user_id].nil?
      username + " | " + logout
    else
      login + " | " + register
    end
  end
  
end
