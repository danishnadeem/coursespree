class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.string :note
      t.integer :university_id
      t.timestamps
    end
  end
end
