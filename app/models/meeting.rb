class Meeting < ActiveRecord::Base
  attr_accessible :paykey, :tutor_availability_id, :paid, :message, :status, :accept, :attendeePW, :location_id, :duration, :moderatorPW, :name, :price, :rating, :start_time, :subject_id, :tutor_id, :user_id
  
  belongs_to :user
  belongs_to :tutor
  belongs_to :tutor_availability
  belongs_to :subject
  belongs_to :tutor_location
  
  #callback method to release tutor's schedule when cancel the meeting
  before_destroy do |meeting|
    ta = TutorAvailability.find(meeting.tutor_availability_id)
    if ta.taken == 1
      ta.taken = 0
      ta.save
    end
  end
  
  def location
    TutorLocation.find(location_id)
  end
  
  #parameter to pass in meeting creation
  def s_id
    if !id.nil?
      'meetingID=' + id.to_s
    end
  end
  
  def p_name
    if !name.nil?
      '&name=' + name.to_s
    end
  end
  def p_modpw
    if !moderatorPW.nil?
      '&moderatorPW=' + moderatorPW.to_s
    end
  end
  def p_attpd
    if !attendeePW.nil?
      '&attendeePW=' + attendeePW.to_s
    end
  end
  def p_duration
    if !tutor_availability.nil?
    '&duration=' + (tutor_availability.length*60).to_s
    end
  end
  def p_logout
    '&logoutURL=http://localhost:3000/meetings/' + id.to_s + '?finish=1'
  end
  def p_recd
    '&record=true'
  end
  
  #parameter to pass in joining meeting
  #will use meetingID from above
  def p_fullname
    if !user.username.nil?
      '&fullName='+ user.fullname
    end
  end
  
  def p_apwd
    if !attendeePW.nil?
    '&password=' + attendeePW
    end
  end
  def p_mpwd
    if !attendeePW.nil?
    '&password=' + moderatorPW
    end
  end

  #querystring to be used for create meeting
  def creatstring
    ( s_id + p_name  + p_modpw + p_attpd + p_duration + p_logout + p_recd).gsub(' ', '+')
  end
  # prep for sha1 sum of querystring-meeting creation
  def createsum
    'create' + creatstring + SALT
  end
  #querystring to be used for join meeting as student
  def stjoinstring
    ( s_id + p_fullname  + p_apwd ).gsub(' ', '+')
  end
  #prep for sha1 sum of querystring-joining meeting as student
  def stjoinsum
    'join' + stjoinstring + SALT
  end
  #qstring to join room as tutor
  def tujoinstring
    ( s_id + p_fullname  + p_mpwd ).gsub(' ', '+')
  end
  #prep fir sha1 sum of join as tutor
  def tujoinsum
    'join' + tujoinstring + SALT
  end
  #prep for sha1 of getmeetinginfo
  def infosum
    'getMeetingInfo' + tujoinstring + SALT
  end
  
  #qstring to check meeting status
  def chkstring
    s_id.gsub(' ', '+')
  end
  #prep for sha1 sum of qstring of check meeting status
  def chksum
    'isMeetingRunning' + chkstring + SALT
  end

  def endstring
    (s_id + p_mpwd).gsub(' ', '+')
  end
  def endsum
    'end' + endstring + SALT
  end
  
  
  
end
