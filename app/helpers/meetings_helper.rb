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
end
