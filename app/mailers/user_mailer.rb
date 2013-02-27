class UserMailer < ActionMailer::Base
  default from: "test.account.rac@gmail.com"
  
  def student_request_for_meeting_to_tutor(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    meeting_tutor = @meeting.tutor
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    #        mail(:to => meeting_tutor.user.email, :subject => "Student requests you for meeting")

    mail(:to => "mahhek.khan@gmail.com", :subject => "Student requests you for meeting, so please approve the pending meeting")
  end

  def tutor_accept_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    #    mail(:to => @student.email, :subject => "Tutor accept your meeting request")
    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept your meeting request")
    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        #      mail(:to => subadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
        mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept the stutent's meeting request")
      end
    end
    all_superadmins.each do |superadmin|
      #      mail(:to => superadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept the stutent's meeting request")
    end
  end
  
  def tutor_reject_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    #    mail(:to => @student.email, :subject => "Tutor accept your meeting request")
    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject your meeting request")
    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        #      mail(:to => subadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
        mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject the stutent's meeting request")
      end
    end
    all_superadmins.each do |superadmin|
      #      mail(:to => superadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject the stutent's meeting request")
    end
  end

  def upcoming_meeting_email_twelve_hours_before(meeting_id)
    #    @meeting = Meeting.find_by_id(meeting_id)
    #    @tutor = @meeting.tutor.user
    #    @student = @meeting.user
    #    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject your meeting request")
  end

  def upcoming_meeting_email_six_hours_before(meeting_id)
    #    @meeting = Meeting.find_by_id(meeting_id)
    #    @tutor = @meeting.tutor.user
    #    @student = @meeting.user
    #    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject your meeting request")
  end

  def upcoming_meeting_email_two_hours_before(meeting_id)
    #    @meeting = Meeting.find_by_id(meeting_id)
    #    @tutor = @meeting.tutor.user
    #    @student = @meeting.user
    #    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject your meeting request")
  end

  def email_reminder_for_meeting_start(meeting_id)
    #    @meeting = Meeting.find_by_id(meeting_id)
    #    @tutor = @meeting.tutor.user
    #    @student = @meeting.user
    #    mail(:to => user.email, :subject => "Registered")
  end
  
  def email_reminder_for_meeting_end(meeting_id)
    #    @meeting = Meeting.find_by_id(meeting_id)
    #    @tutor = @meeting.tutor.user
    #    @student = @meeting.user
    #    mail(:to => user.email, :subject => "Registered")
  end
end