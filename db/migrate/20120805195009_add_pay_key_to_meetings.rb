class AddPayKeyToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :paykey, :string
  end
end
