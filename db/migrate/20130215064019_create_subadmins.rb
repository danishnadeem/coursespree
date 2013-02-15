class CreateSubadmins < ActiveRecord::Migration
  def change
    create_table :subadmins do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
