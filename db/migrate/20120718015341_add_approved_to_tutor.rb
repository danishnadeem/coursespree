class AddApprovedToTutor < ActiveRecord::Migration
  def change
    add_column :tutors, :approved, :integer, :default => 0
  end
end
