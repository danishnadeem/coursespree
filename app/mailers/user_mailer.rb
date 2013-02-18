class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  def email_reminder_before_email_sent(tutor , student)
    mail(:to => user.email, :subject => "Registered", :from => "eifion@asciicasts.com")
  end  
end
