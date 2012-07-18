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
end
