class AddTutorAvailabilityToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :tutor_availability_id, :integer
  end
end
