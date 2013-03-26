class UserMailer < ActionMailer::Base
  default :from => "test.account.rac@gmail.com"
  
  def student_request_for_meeting_to_tutor(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    #    mail(:to => "mahhek.khan@gmail.com", :subject => "Student requests you for meeting, so please approve the pending meeting") do |format|
    #      format.text
    #      format.html { render "cronjobs/email_sent_successfully" }
    #    end

    mail(:to => "mahhek.khan@gmail.com", :cc => "danishnadeem@gmail.com", :subject => "Student requests you for meeting, so please approve the pending meeting", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )
   
    #    mail(:to => @tutor.email, :cc => @student.email, :subject => "Student requests you for meeting, so please approve the pending meeting")
  end

  def tutor_accept_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    mailling_list = []

    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        mailling_list << subadmin.user.email
      end
    end

    all_superadmins.each do |superadmin|
      mailling_list << superadmin.user.email
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    mail(:to => "mahhek.khan@gmail.com", :cc => "danishnadeem@gmail.com", :subject => "Tutor has accepted student's meeting request", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )
    #    mail(:bcc => mailling_list, :subject => "Tutor accept the stutent's meeting request", :content_type => 'text/html')
  end
  
  def tutor_reject_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    mailling_list = []

    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        mailling_list << subadmin.user.email
      end
    end

    all_superadmins.each do |superadmin|
      mailling_list << superadmin.user.email
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    #    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor has rejected the student's meeting request", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )

    mail(:to => "mahhek.khan@gmail.com", :cc => "danishnadeem@gmail.com", :subject => "Tutor has accepted student's meeting request", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )
    #    mail(:to => @student.email, :cc => mailling_list , :subject => "Tutor reject the stutent's meeting request", :from => "meetings@tutorsprout.com", :content_type => 'text/html')

  end

  def admin_subadmin_create_meeting(meeting_id , usr)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    if usr.superadmin.present?
      #    mail(:to => "mahhek.khan@gmail.com", :subject => "SubAdmin Create meeting", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )
    elsif usr.subadmin.present?
      #    mail(:to => "mahhek.khan@gmail.com", :subject => "SubAdmin Create meeting", :from => "meetings@tutorsprout.com", :content_type => 'text/html' )
    end

    mailling_list = []

    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        mailling_list << subadmin.user.email
      end
    end

    all_superadmins.each do |superadmin|
      mailling_list << superadmin.user.email
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    #    mail(:bcc => mailling_list, :subject => "SuperAdmin Or SubAdmin Create meeting", :content_type => 'text/html')

    mail(:to => "mahhek.khan@gmail.com", :cc => "danishnadeem@gmail.com", :subject => "SuperAdmin Or SubAdmin Create meeting", :content_type => 'text/html')
  end

  def upcoming_meeting_email_twelve_hours_before(meeting_id)
    xxxxx
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    
    mailling_list = []
    
    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end

    mailling_list << @student.email
    mailling_list = mailling_list.join(',')
    mailling_list << @tutor.email

    #    mail(:to => "faisalmaqbool888@gmail.com", :subject => "Just check cronjob working", :from => "meetings@tutorsprout.com", :content_type => 'text/html')
    #    mail(:bcc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 6 hours remains in the start of meeting time", :content_type => 'text/html')
  end

  def upcoming_meeting_email_six_hours_before(meeting_id)
    zzzzz
    #    meeting_id = 25
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mailling_list = []

    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')
    
    #    mailling_list << "faisalmaqbool888@gmail.com"
    #    mailling_list << "mahhek.khan@gmail.com"
    #    mailling_list << "faisalmalik_11@yahoo.com"

    #    mail(:bcc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 6 hours remains in the start of meeting time", :content_type => 'text/html')
    #    mail(:to => @student.email, :cc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 6 hours remains in the start of meeting time", :from => "meetings@tutorsprout.com", :content_type => 'text/html')

  end
  
  def upcoming_meeting_email_two_hours_before(meeting_id)
    xxxxxxxx
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mailling_list = []

    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    #    mail(:bcc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 2 hours remains in the start of meeting time", :content_type => 'text/html')
    #    mail(:to => @student.email, :cc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 2 hours remains in the start of meeting time", :from => "meetings@tutorsprout.com", :content_type => 'text/html')
  end

  def email_reminder_for_meeting_start(meeting_id)
    cccccccc
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    mailling_list = []

    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        mailing_list << subadmin.user.email
      end
    end

    all_superadmins.each do |superadmin|
      mailing_list << superadmin.user.email
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    #    mail(:bcc => mailling_list, :subject => "The meeting has started", :content_type => 'text/html')
    #    mail(:to => @student.email , :cc => mailling_list, :subject => "The meeting has started", :from => "meetings@tutorsprout.com", :content_type => 'text/html')

  end
  
  def email_reminder_for_meeting_end(meeting_id)
    sssss
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    mailling_list = []

    all_subadmins.each do |subadmin|
      if subadmin.user.department == @student.department
        mailing_list << subadmin.user.email
      end
    end
    all_superadmins.each do |superadmin|
      mailing_list << superadmin.user.email
    end

    mailling_list << @tutor.email
    mailling_list << @student.email
    mailling_list = mailling_list.join(',')

    #    mail(:bcc => mailling_list, :subject => "The meeting has ended", :content_type => 'text/html')
    #    mail(:to => @student.email , :cc => mailling_list,  :subject => "The meeting has ended", :from => "meetings@tutorsprout.com", :content_type => 'text/html')
  end
end