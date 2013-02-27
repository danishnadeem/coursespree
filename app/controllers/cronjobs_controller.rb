class CronjobsController < ApplicationController
  def reminder_email_before_twelve_hours
    #    in_reminder_email_before_twelve_hours
    
    meetings = Meeting.all

    error_in_emails = 0

    meetings.each do |meeting|
      #      a = DateTime.now.strftime("%d:%m:%Y-%H:%M:%S")
      #      b = meeting.tutor_availability.start_time.strftime("%d:%m:%Y-%H:%M:%S")

      if meeting.tutor_availability.start_time >= DateTime.now
        meeting_month = meeting.tutor_availability.start_time.strftime("%m").to_i
        meeting_day = meeting.tutor_availability.start_time.strftime("%d").to_i

        now_month = DateTime.now.strftime("%m").to_i
        now_day = DateTime.now.strftime("%d").to_i

        #"same dates but hours,minutes and seconds difference"

        if (meeting_day == now_day) && (meeting_month == now_month) && (meeting.tutor_availability.start_time.strftime("%Y").to_i == DateTime.now.strftime("%Y").to_i)
          if meeting.tutor_availability.start_time.strftime("%H:%M:%S") >= DateTime.now.strftime("%H:%M:%S") && (meeting.upcoming_meeting_email_twelve_hours_before == false)
            now_hour = DateTime.now.strftime("%H:%M:%S").to_f
            now_hour = now_hour+12
            if now_hour >= meeting.tutor_availability.start_time.strftime("%H:%M:%S").to_f && meeting.has_code == false
              xxxx
              error_in_emails = 0
              meeting.update_attribute(:upcoming_meeting_email_twelve_hours_before => true)
              UserMailer.upcoming_meeting_email_twelve_hours_before(meeting.id).deliver
            else
              error_in_emails = 1
            end
          else
            error_in_emails = 1
          end
        else
          error_in_emails = 1
        end
      else
        error_in_emails = 1
      end
    end

    if error_in_emails == 1
      #      render :partial => "error_in_emails", :locals => { :name => "mahhek" }
      render :template => "/cronjobs/error_in_emails"
    end
  end
  
  def reminder_email_before_six_hours
    #    in_reminder_email_before_six_hours

    meetings = Meeting.all

    error_in_emails = 0

    meetings.each do |meeting|
      if meeting.tutor_availability.start_time >= DateTime.now
        meeting_month = meeting.tutor_availability.start_time.strftime("%m").to_i
        meeting_day = meeting.tutor_availability.start_time.strftime("%d").to_i

        now_month = DateTime.now.strftime("%m").to_i
        now_day = DateTime.now.strftime("%d").to_i

        #"same dates but hours,minutes and seconds difference"

        if (meeting_day == now_day) && (meeting_month == now_month) && (meeting.tutor_availability.start_time.strftime("%Y").to_i == DateTime.now.strftime("%Y").to_i)
          if meeting.tutor_availability.start_time.strftime("%H:%M:%S") > DateTime.now.strftime("%H:%M:%S") && (meeting.upcoming_meeting_email_six_hours_before == false)
            now_hour = DateTime.now.strftime("%H:%M:%S").to_f
            now_hour = now_hour+6
            if now_hour >= meeting.tutor_availability.start_time.strftime("%H:%M:%S").to_f && meeting.has_code == false
              xxxx
              error_in_emails = 0
              meeting.update_attribute(:upcoming_meeting_email_six_hours_before => true)
              UserMailer.upcoming_meeting_email_six_hours_before(meeting.id).deliver
            else
              error_in_emails = 1
            end
          else
            error_in_emails = 1
          end
        else
          error_in_emails = 1
        end
      else
        error_in_emails = 1
      end
    end

    if error_in_emails == 1
      #      render :partial => "error_in_emails", :locals => { :name => "mahhek" }
      render :template => "/cronjobs/error_in_emails"
    end

  end

  def reminder_email_before_two_hours
    #    in_reminder_email_before_two_hours

    meetings = Meeting.all

    error_in_emails = 0

    meetings.each do |meeting|
      if meeting.tutor_availability.start_time >= DateTime.now
        meeting_month = meeting.tutor_availability.start_time.strftime("%m").to_i
        meeting_day = meeting.tutor_availability.start_time.strftime("%d").to_i

        now_month = DateTime.now.strftime("%m").to_i
        now_day = DateTime.now.strftime("%d").to_i

        #"same dates but hours,minutes and seconds difference"

        if (meeting_day == now_day) && (meeting_month == now_month) && (meeting.tutor_availability.start_time.strftime("%Y").to_i == DateTime.now.strftime("%Y").to_i)
          if meeting.tutor_availability.start_time.strftime("%H:%M:%S") > DateTime.now.strftime("%H:%M:%S")
            now_hour = DateTime.now.strftime("%H:%M:%S").to_f
            now_hour = now_hour+2
            if now_hour >= meeting.tutor_availability.start_time.strftime("%H:%M:%S").to_f 
              xxxx
              error_in_emails = 0
              UserMailer.upcoming_meeting_email_two_hours_before(meeting.id).deliver
            else
              error_in_emails = 1
            end
          else
            error_in_emails = 1
          end
        else
          error_in_emails = 1
        end
      else
        error_in_emails = 1
      end
    end

    if error_in_emails == 1
      #      render :partial => "error_in_emails", :locals => { :name => "mahhek" }
      render :template => "/cronjobs/error_in_emails"
    end

  end

  def reminder_email_when_meeting_starts
    #    in_reminder_email_when_meeting_starts
    
    meetings = Meeting.all

    error_in_emails = 0

    meetings.each do |meeting|
      if meeting.tutor_availability.start_time <= DateTime.now && meeting.start_meeting_email_sent == false
        xxxx
        meeting.update_attribute(:start_meeting_email_sent => true)
        error_in_emails = 0
        UserMailer.email_reminder_for_meeting_start(meeting.id).deliver
      else
        error_in_emails = 1
      end
    end
    if error_in_emails == 1
      #      render :partial => "error_in_emails", :locals => { :name => "mahhek" }
      render :template => "/cronjobs/error_in_emails"
    end
  end

  def reminder_email_when_meeting_ends
    #    in_reminder_email_when_meeting_ends

    meetings = Meeting.all

    error_in_emails = 0

    meetings.each do |meeting|
      if meeting.tutor_availability.end_time <= DateTime.now && meeting.end_meeting_email_sent == false
        xxxx
        error_in_emails = 0
        meeting.update_attribute(:end_meeting_email_sent => true)
        UserMailer.email_reminder_for_meeting_end(meeting.id).deliver
      else
        error_in_emails = 1
      end
    end
    if error_in_emails == 1
      #      render :partial => "error_in_emails", :locals => { :name => "mahhek" }
      render :template => "/cronjobs/error_in_emails"
    end
  end
end
