class UserMailer < ActionMailer::Base
  default from: "test.account.rac@gmail.com"
  def email_reminder_before_email_sent(tutor , student)
    mail(:to => user.email, :subject => "Registered")
  end

  def tutor_accept_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    #    tutor = @meeting.tutor
    student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    #
    #    puts "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    #    puts student.inspect
    #    puts all_subadmins.inspect
    #    puts all_superadmins.inspect
    #    puts @meeting.inspect


    #    mail(:to => student.email, :subject => "Tutor accept your meeting request")
    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept your meeting request")
    all_subadmins.each do |subadmin|
      #      mail(:to => subadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept the stutent's meeting request")
    end
    all_superadmins.each do |superadmin|
      #      mail(:to => superadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor accept the stutent's meeting request")
    end
  end
  
  def tutor_reject_meeting_request(meeting_id)
    @meeting = Meeting.find_by_id(meeting_id)
    #    tutor = @meeting.tutor
    student = @meeting.user
    all_subadmins = Subadmin.all
    all_superadmins = Superadmin.all

    #    mail(:to => student.email, :subject => "Tutor accept your meeting request")
    mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject your meeting request")
    all_subadmins.each do |subadmin|
      #      mail(:to => subadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject the stutent's meeting request")
    end
    all_superadmins.each do |superadmin|
      #      mail(:to => superadmin.user.email, :subject => "Tutor accept the stutent's meeting request")
      mail(:to => "mahhek.khan@gmail.com", :subject => "Tutor reject the stutent's meeting request")
    end
  end

  def student_request_for_meeting_to_tutor
    tutor = @meeting.tutor
    #    mail(:to => tutor.user.email, :subject => "Tutor accept your meeting request")

    mail(:to => "mahhek.khan@gmail.com", :subject => "Student requests for meeting to tutor")
  end
end
