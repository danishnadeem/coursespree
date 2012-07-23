module MeetingsHelper
  def meetingheader
    if params[:type]== 'pending'
      'Pending Meetings'
    elsif  params[:type]=='past'
      'Past Meetings'
    elsif  params[:type]=='requested'
      'Your Requested Meetings'
    end
  end
  
  def meetinginfo
    #to be used at new meeting page
    TutorAvailability.find(params[:avlb_id])
  end
  
  def youaretutor
    Meeting.find(:all, :conditions => ['tutor_id = ? AND accept = ?', session[:tutor_id], 1])
  end
  
  def youarestudent
    Meeting.find(:all, :conditions => ['user_id = ? AND accept = ?', session[:user_id], 1])
  end
  
  def paymentlink
    if @meeting.accept == 1 && @meeting.user_id == session[:user_id] && @meeting.paid == false
      link_to 'Make payment'
    end 
  end
  
  def meetingstatus
    if @meeting.accept == 1
      'scheduled'
    else
      'waiting tutor response'
    end
  end
  
  def acceptlink
    if @meeting.accept == 0 && @meeting.tutor_id == session[:tutor_id]
      link_to 'accept', :controller => 'meetings', :action => 'show', :accept=>'1'
    end 
  end

end
