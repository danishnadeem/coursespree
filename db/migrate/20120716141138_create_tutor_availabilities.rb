class CreateTutorAvailabilities < ActiveRecord::Migration
  def change
    create_table :tutor_availabilities do |t|
      t.integer :tutor_id
      t.integer :dayofweek
      t.datetime :start_time
      t.integer :length
      t.integer :weeksche_mark

      t.timestamps
    end
  end
end
