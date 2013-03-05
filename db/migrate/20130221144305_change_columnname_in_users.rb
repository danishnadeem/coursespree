class ChangeColumnnameInUsers < ActiveRecord::Migration
  def change    
    rename_column :users, :fName, :fname
    rename_column :users, :lName, :lname
  end
end
