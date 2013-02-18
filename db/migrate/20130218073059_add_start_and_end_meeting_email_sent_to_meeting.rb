class AddStartAndEndMeetingEmailSentToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :start_meeting_email_sent, :integer, :default => 0
    add_column :meetings, :end_meeting_email_sent, :integer, :default => 0
  end
end
