class Meeting < ActiveRecord::Base
  attr_accessible :paykey, :tutor_availability_id, :paid, :message, :status, :accept, :attendeePW, :location_id,
    :duration, :moderatorPW, :name, :price, :rating, :subject_id, :tutor_id, :user_id, :has_code
  
  belongs_to :user
  belongs_to :tutor
  belongs_to :tutor_availability
  belongs_to :subject
  belongs_to :tutor_location
  belongs_to :transaction

  #callback method to release tutor's schedule when cancel the meeting while the meeting didn't happen
  before_destroy do |meeting|
    ta = meeting.tutor_availability
    #puts "before debug"
    #p ta.start_time.to_s + " time " + Time.now.to_s
    #puts ta.start_time > Time.now
    if ta.taken == 1 && ta.start_time > Time.now
      ta.taken = 0
      ta.save!
    end
  end
  
  def location
    TutorLocation.find(location_id)
  end
  
  def buildurl(req_str,action)
    'http://198.101.200.137/bigbluebutton/api/' + action +'?' + req_str + '&checksum=' + Digest::SHA1.hexdigest(action + req_str + SALT)
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
    '&logoutURL=http://tutorsprout.info/meetings/' + id.to_s + '?finish=1'
  end
  
  
  def logouturl
    Rails.env == 'production'? "http://tutorsprout.info/meetings/": "http://tutorsprout.info/meetings/"
  end
  
  def p_recd
    '&record=true'
  end
  
  #parameter to pass in joining meeting
  #will use meetingID from above
  def p_st_fullname
    if !user.username.nil?
      '&fullName='+ user.fullname
    end
  end
  def p_tu_fullname
    if !user.username.nil?
      '&fullName='+ tutor.user.fullname
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
  #def creatstring
  #  #( s_id + p_name  + p_modpw + p_attpd + p_duration + p_logout + p_recd).gsub(' ', '+')
  #  start_str = 'meetingID=' + id.to_s + '&logoutURL=http://coursespree.info/meetings/' + id.to_s + '?finish=1&record=true'
  #  if !name.nil?
  #    start_str+=('&name=' + name.to_s)
  #  end
  #  
  #  if !moderatorPW.nil?
  #    start_str+='&moderatorPW=' + moderatorPW.to_s
  #  end
  #  
  #  if !attendeePW.nil?
  #    start_str+='&attendeePW=' + attendeePW.to_s
  #  end
  #  
  #  if !tutor_availability.nil?
  #    start_str+='&duration=' + (tutor_availability.length*60).to_s
  #  end
  #  # prep for sha1 sum of querystring-meeting creation
  #    return start_str.gsub(' ','+')
  #end
  # commented because combined directly
  
  def createuri
    start_str = 'meetingID=' + id.to_s 
    if !name.nil?
      start_str+=('&name=' + name.to_s)
    end
    
    if !moderatorPW.nil?
      start_str+='&moderatorPW=' + moderatorPW.to_s
    end
    
    if !attendeePW.nil?
      start_str+='&attendeePW=' + attendeePW.to_s
    end
    
    if !tutor_availability.nil?
      start_str+='&duration=' + (tutor_availability.length*60).to_s + '&logoutURL='+ logouturl + id.to_s + '?finish=1&record=true'
    end #finishing up the querystring to calculate checksum
    #
    start_str.gsub!(" ","+")
    buildurl(start_str,"create")
  end
  
  #querystring to be used for join meeting as student
  def stjoinuri
    start_str = 'meetingID=' + id.to_s
    if !user.username.nil?
      start_str+='&fullName='+ user.fullname
    end    
    
    if !attendeePW.nil?
      start_str+='&password=' + attendeePW
    end    
    
    start_str.gsub!(' ', '+')
    buildurl(start_str,"join")
  end
  #prep for sha1 sum of querystring-joining meeting as student
  #def stjoinsum
  #  'join' + stjoinstring + SALT
  #end
  
  #request uri to join room as tutor
  def tujoinuri
    start_str = 'meetingID=' + id.to_s
    if !user.username.nil?
      start_str+='&fullName='+ tutor.user.fullname
    end    
    
    if !moderatorPW.nil?
      start_str+='&password=' + moderatorPW
    end    
    start_str.gsub!(' ', '+')
    buildurl(start_str,"join")
  end
  
  
  #prep fir sha1 sum of join as tutor
  #def tujoinsum
  #  'join' + tujoinstring + SALT
  #end
  
  
  #prep for sha1 of getmeetinginfo
  #meeting info api call not used
  #def infosum
  #  'getMeetingInfo' + tujoinstring + SALT
  #end
  
  #qstring to check meeting status
  #def chkstring
  #  s_id.gsub(' ', '+')
  #end
  #prep for sha1 sum of qstring of check meeting status
  def runningurl
    buildurl('meetingID=' + id.to_s,"isMeetingRunning")
  end

  def endstring
    (s_id + p_mpwd).gsub(' ', '+')
  end
  def endurl
    buildurl(('meetingID=' + id.to_s + '&password=' + moderatorPW.to_s).gsub(' ', '+'), "end")
  end
end
