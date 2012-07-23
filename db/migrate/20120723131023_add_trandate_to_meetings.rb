class AddTrandateToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :trandate, :datetime
  end
end
