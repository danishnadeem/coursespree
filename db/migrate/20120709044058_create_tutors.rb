class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.integer :user_id
      t.integer :approved, :default => 0

      t.timestamps
    end
  end
end
