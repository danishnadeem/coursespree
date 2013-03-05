class AddRateToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :rate, :decimal, :precision => 5, :scale => 2, :default => 0.00
  end
end
