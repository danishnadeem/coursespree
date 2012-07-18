class CreateSubjectsTutors < ActiveRecord::Migration
  def change
    create_table :subjects_tutors do |t|
      t.integer :subject_id
      t.integer :tutor_id

      t.timestamps
    end
  end
end
