class AddMessageToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :message, :text
  end
end
