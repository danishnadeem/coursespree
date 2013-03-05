class RemoveDurationStartTimeFromMeetings < ActiveRecord::Migration
  def up
    remove_column :meetings, :duration
    remove_column :meetings, :start_time
  end

  def down
    add_column :meetings, :start_time, :datetime
    add_column :meetings, :duration, :string
  end
end
