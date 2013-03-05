class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :timetype
      t.integer :taken , :default => 0
      t.integer :tutor_id
      t.datetime :start_time
      t.integer :length

      t.timestamps
    end
  end
end
