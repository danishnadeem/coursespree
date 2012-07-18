class CreateTutorAvailabilities < ActiveRecord::Migration
  def change
    create_table :tutor_availabilities do |t|
      t.integer :tutor_id
      t.datetime :time_start
      t.datetime :time_end
      t.integer :weekly

      t.timestamps
    end
  end
end
