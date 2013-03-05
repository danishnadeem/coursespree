class RemoveWeekscheMarkFromTutorAvailabilities < ActiveRecord::Migration
  def up
    remove_column :tutor_availabilities, :weeksche_mark
  end

  def down
    add_column :tutor_availabilities, :weeksche_mark, :integer
  end
end
