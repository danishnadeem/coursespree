class UserMailer < ActionMailer::Base
  default :from => "test.account.rac@gmail.com"
  
  def student_request_for_meeting_to_tutor(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mail(:to => "mahhek.khan@gmail.com", :subject => "Student requests you for meeting, so please approve the pending meeting") do |format|
      format.text
      format.html { render "cronjobs/email_sent_successfully" } 
    end
    

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

    #    mail(:to => @student.email, :cc => mailling_list  ,:subject => "Tutor accept the stutent's meeting request")

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

    #    mail(:to => @student.email, :cc => mailling_list , :subject => "Tutor reject the stutent's meeting request")

  end

  def upcoming_meeting_email_twelve_hours_before(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mailling_list = []

    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end
        
    mailling_list << @tutor.email

    #    mail(:to => @student.email, :cc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 12 hours remains in the start of meeting time")

  end

  def upcoming_meeting_email_six_hours_before(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mailling_list = []

    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end

    mailling_list << @tutor.email

    #    mail(:to => @student.email, :cc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 6 hours remains in the start of meeting time")

  end

  def upcoming_meeting_email_two_hours_before(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    @tutor = @meeting.tutor.user
    @student = @meeting.user

    mailling_list = []

    all_superadmins = Superadmin.all
    all_superadmins.each do |superadmin|
      mailling_list << superadmin
    end

    mailling_list << @tutor.email

    #    mail(:to => @student.email, :cc => mailling_list, :subject => "Upcoming meeting is still unpaid while only 2 hours remains in the start of meeting time")

  end

  def email_reminder_for_meeting_start(meeting_id)
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

    #    mail(:to => @student.email , :cc => mailling_list, :subject => "The meeting has started")

  end
  
  def email_reminder_for_meeting_end(meeting_id)
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

    #    mail(:to => @student.email , :cc => mailling_list, :subject => "The meeting has ended")

  end
end