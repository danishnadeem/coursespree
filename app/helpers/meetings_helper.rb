module MeetingsHelper
  
  def meetingstatus(i)
    if i == 0
      "initiated"
    elsif i == -1
      "rejected"
    elsif i == 1
      "accepted"
    elsif i == 2
      "paid"
    elsif i == 3
      "started"
    elsif i == 4
      "finished"
    end
  end
  
  def meetingheader
    case params[:type]
    when 'pending'
      session[:tutor_id]? 'Received following appointment request':'Waiting tutor response'
    when 'past'
      'Past Meetings'
    when 'attending'
      'You will be attending'
    end
    #if params[:type]== 'pending'
    #  session[:tutor_id]? 'Received following appointment request':'Waiting tutor response'
    #elsif  params[:type]=='past'
    #  'Past Meetings'
    #elsif  params[:type]=='attending'
    #  'You will be attending'
    #end
  end
  
  def meetinginfo
    if params[:action] == 'new'
      #to be used at new meeting page
      TutorAvailability.find(params[:avlb_id])
    elsif params[:action] == 'edit'
      @meeting.tutor_availability
    end
  end
  
  def youaretutor
    Meeting.find(:all, :conditions => ['tutor_id = ? AND accept = ? AND status != 3', session[:tutor_id], 1])
  end
  
  def youarestudent
    Meeting.find(:all, :conditions => ['user_id = ? AND accept = ? AND status != 3', session[:user_id], 1])
  end

  def paymentlink
    if @meeting.accept == 1 && @meeting.user_id == session[:user_id] && @meeting.paid == false
      button_to 'pay', :controller => 'meetings', :action => 'payment', :mid=> @meeting.id
    end 
  end
  
  def meeting_status(i)
    if i == 1
      'scheduled'
    elsif i == -1
      'rejected'
    elsif i == 2
      'started'
    elsif i == 3
      'finished'
    else
      'waiting'
    end
  end
  
  def acceptlink
    if @meeting.accept == 0 && @meeting.tutor_id == session[:tutor_id]
      (link_to 'accept', :controller => 'meetings', :action => 'show', :accept=>1) + " | " + (link_to 'reject', :controller => 'meetings', :action => 'show', :accept=>-1)
    end 
  end

end
