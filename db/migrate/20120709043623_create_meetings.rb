class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :name
      t.string :attendeePW
      t.string :moderatorPW
      t.string :duration
      t.string :classlink
      t.string :subject
      t.datetime :start_time
      t.integer :tutor_id
      t.integer :user_id
      t.float :price
      t.integer :rating
      t.integer :accept, :default => 0

      t.timestamps
    end
  end
end
