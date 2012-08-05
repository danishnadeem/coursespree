class AddTakenToTutorAvailabilities < ActiveRecord::Migration
  def change
    add_column :tutor_availabilities, :taken, :integer, :default => 0
  end
end
