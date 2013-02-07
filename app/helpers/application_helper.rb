module ApplicationHelper
  def current_admin?
    User.find(session[:user_id]).usertype == "superadmin"
  end
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  
#link related with authentication definition
  def username
    link_to current_user.username + "(" + current_user.fullname + ")", current_user
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
   '('+Meeting.find(:all, :conditions=> ["accept =0 and status = 0 and (tutor_id = ? or user_id = ?)", session[:tutor_id], session[:user_id]]).count.to_s+')'
  end

  def pending
    if current_user.usertype != 'superadmin'
      link_to 'Pending' + pendcnt , :controller => 'meetings', :type => 'pending'
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
    if !session[:user_id].nil? && current_user.usertype == 'tutor' && current_user == @user 
      
    elsif !session[:user_id].nil? && current_user.usertype == 'tem_tutor' && current_user == @user
      'your tutor application is awaiting approval'
    elsif !session[:user_id].nil? && current_user.usertype == 'student' && current_user == @user
      link_to 'apply to be tutor', new_tutor_url(:uid => session[:user_id])
    end
  end

#navigation link definition
  def findtutor
    link_to 'Find Tutor', :controller => 'tutors' 
  end
  
  def meetings
    link_to 'Waiting Tutor Response', :controller => 'meetings', :type => 'requested' 
  end
  
  def attend
    link_to 'You Will Attend', :controller => 'meetings', :type => 'attending' 
  end

  def past
    link_to 'Past Meetings', :controller=> 'meetings', :type => 'past'
  end
#navigation link definition for admin

  def user_mgmt
    link_to 'users', users_path
  end
  
  def subject_mgmt
    link_to 'subjects', subjects_path
  end

  def tutor_mgmt
    link_to 'tutors', :controller => 'tutors', :action => 'mgmt', :type=> 'pending'
  end
  
  def meeting_mgmt
    link_to 'meetings', meetings_path
  end
  
  def univ_mgmt
    link_to 'universities', universities_path
  end
  
  def location_mgmt
    link_to 'tutor locations',  tutor_locations_path
  end
#navigation link
  def navlinks
      if !session[:user_id]
      findtutor
      elsif current_user.usertype == 'tutor'# if user is tutor
        findtutor + " | "  + attend  + " | " + past
      elsif current_user.usertype == 'student' || current_user.usertype == 'tem_tutor'#if user is student
        findtutor + " | " + attend + " | " + past
      elsif current_user.usertype == 'superadmin'#if user is administrator
        tutor_mgmt + " | " + user_mgmt + " | " + subject_mgmt + " | " + meeting_mgmt + " | " + univ_mgmt + " | " + location_mgmt
      end
  end
  
end
