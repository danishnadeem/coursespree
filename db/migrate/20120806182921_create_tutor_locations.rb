class CreateTutorLocations < ActiveRecord::Migration
  def change
    create_table :tutor_locations do |t|
      t.string :name
      t.integer :university_id

      t.timestamps
    end
  end
end
