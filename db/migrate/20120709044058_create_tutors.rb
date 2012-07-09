class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.integer :user_id
      t.string :transcript
      t.string :resume
      t.string :university
      t.string :univ_identifier

      t.timestamps
    end
  end
end
