class AddStartAndEndMeetingEmailSentToMeeting < ActiveRecord::Migration
  def change
#    add_column :meetings, :start_meeting_email_sent, :boolean, :default => false
#    add_column :meetings, :end_meeting_email_sent, :boolean, :default => false
#    add_column :meetings, :upcoming_meeting_email_six_hours_before, :boolean, :default => false
#    add_column :meetings, :upcoming_meeting_email_twelve_hours_before, :boolean, :default => false
    remove_column :meetings, :start_meeting_email_sent, :boolean, :default => false
    remove_column :meetings, :end_meeting_email_sent, :boolean, :default => false
  end
end
