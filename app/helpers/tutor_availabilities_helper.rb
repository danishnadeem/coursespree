module TutorAvailabilitiesHelper
  def dayofweek(i)
    if i==1
      'Mon'
    elsif i==2
      'Tue'
    elsif i==3
      'Wed'
    elsif i==4
      'Thur'
    elsif i==5
      'Fri'
    elsif i==6
      'Sat'
    elsif i==0
      'Sun'
    else
      'errorinput'
    end
  end
end
