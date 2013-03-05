class AddTypeToTutorAvailability < ActiveRecord::Migration
  def change
    add_column :tutor_availabilities, :timetype, :integer
  end
end
