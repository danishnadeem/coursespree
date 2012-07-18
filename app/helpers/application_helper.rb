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
  
#link related with authentication definition
  def username
    user = User.find(session[:user_id])
    link_to user.username, user
  end
  
  def logout
    link_to 'logout', '/admin/logout'
  end
  
  def register
    link_to 'register', '/register'
  end
  
  def login
    link_to 'login', '/admin/login'
  end
  

  def pendcnt
   '('+Meeting.find(:all, :conditions=> ["tutor_id = ? and accept =?", session[:user_id], 0]).count.to_s+')'
  end

  def pending
    if current_user.usertype == 'tutor'
      link_to 'Pending Meetings' + pendcnt , :controller => 'meetings', :type => 'pending'
    elsif current_user.usertype == 'student'
      link_to 'Your Meetings', :controller => 'meetings', :type => 'requested'
    elsif current_user.usertype == 'superadmin'
    end
  end
#authentication link usage
  def authlink
    if !session[:user_id].nil? && current_user.usertype == 'superadmin'
      username + " | " + logout
    elsif !session[:user_id].nil?
      pending + " | " + username + " | " + logout
    else
      login + " | " + register
    end
  end
  
#tutor application link
  def tuapply
    if !session[:user_id].nil? && current_user.usertype != 'tutor' && current_user == @user 
      link_to 'apply for tutor', new_tutor_url(:uid => session[:user_id])
    end
  end

#navigation link definition
  def findtutor
    link_to 'Find Tutor', :controller => 'tutors' 
  end
  
  def meetings
    link_to 'Requested Meetings', :controller => 'meetings', :type => 'requested' 
  end
  
  def past
    link_to 'Past Meetings', :controller => 'meetings', :type => 'past' 
  end

#navigation link definition for admin

  def user_mgmt
    link_to 'user management', users_path
  end
  
  def subject_mgmt
    link_to 'subject management', subjects_path
  end

  def tutor_mgmt
    link_to 'tutor management', tutors_path
  end
  
  def meeting_mgmt
    link_to 'meeting_management', meetings_path
  end
#navigation link
  def navlinks
    if !session[:user_id].nil?# if user logged in display nav links 
      if current_user.usertype == 'tutor'# if user is tutor
        findtutor + " | " + meetings  + " | " + past
      elsif current_user.usertype == 'student'#if user is student
        findtutor + " | " + meetings
      elsif current_user.usertype == 'superadmin'#if user is administrator
        user_mgmt + " | " + subject_mgmt + " | " + tutor_mgmt + " | " + meeting_mgmt
      end
    end
  end
  
end
