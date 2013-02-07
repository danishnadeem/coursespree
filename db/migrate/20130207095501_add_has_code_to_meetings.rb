class AddHasCodeToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :has_code, :boolean, :default => false
  end
end
