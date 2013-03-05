class AddPaidToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :paid, :boolean, :default => false
  end
end
