class AlterMeeting < ActiveRecord::Migration
  def self.up
    add_column :meetings, :location_id, :integer
    add_column :meetings, :subject_id, :integer
    remove_column :meetings, :classlink
    remove_column :meetings, :subject
  end
  
  def self.down
    remove_column :meetings, :location_id
    remove_column :meetings, :subject_id
    add_column :meetings, :classlink, :string
    add_column :meetings, :subject, :integer   
  end
end
