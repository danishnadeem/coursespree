module TutorAvailabilitiesHelper
  def dayofweek(i)
    if i==1
      'Monday'
    elsif i==2
      'Tuesday'
    elsif i==3
      'Wednesday'
    elsif i==4
      'Thursday'
    elsif i==5
      'Friday'
    elsif i==6
      'Saturday'
    elsif i==0
      'Sunday'
    else
      'errorinput'
    end
  end
end
