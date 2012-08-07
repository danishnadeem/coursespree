module TutorsHelper
  def search(keyword)
    link_to keyword, :controller => 'tutors', :action => 'index'
  end
  
  def matchlinks
    display = "Matched Subjects: "
    if !@matches.nil? && @matches.count > 0
      @matches.each do  |mat|
        display += mat + ", "
      end
    else
      display = 'No Matches'
    end
    display
  end
  
  def schedulelink(av_id)
    if params[:id].to_s != session[:user_id].to_s #session[:user_id].nil? || session[:tutor_id] != TutorAvailability.find(av_id).tutor_id
      link_to 'make appointment',:controller => 'meetings', :action=> 'new',  :avlb_id => av_id
    end
  end
  
  def docupdate_link
    if current_user == @user 
      link_to 'update', edit_tutor_path(@user.tutor)
    end
  end
  
  def approve_link(t)
    if t.approved == 0
      link_to 'approve', :action => 'approve', :tid=> t.id
    else
      'Status: approved'
    end
  end
  
  def pend_tut_cnt
    '(' + session[:pendtut_cnt].to_s + ')'
  end
  
  def pendting_tutor
    link_to 'pending tutor application' + pend_tut_cnt , :action => 'mgmt', :type => 'pending'
  end
  
  def current_tutor
    link_to 'current tutors', :action => 'mgmt', :type => 'current' 
  end
  
  def all_tutors
    link_to 'all tutors', :action =>'mgmt' ,:type => 'all'
  end
  
  def tutor_mgmt_links 
    pendting_tutor + ' | ' + current_tutor + ' | ' + all_tutors
  end
  
  def schedule_mgmt_link
    if params[:id].to_s == session[:user_id].to_s
      link_to 'Manage Open Schedule', :controller => 'tutor_availabilities', :action => 'index'
    end
  end
  

  
end

