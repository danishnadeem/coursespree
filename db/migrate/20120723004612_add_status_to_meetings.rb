class AddStatusToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :status, :integer
  end
end
