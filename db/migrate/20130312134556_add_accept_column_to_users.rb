class AddAcceptColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accept, :boolean
  end
end
