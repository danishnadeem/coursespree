class CreateSuperadmins < ActiveRecord::Migration
  def change
    create_table :superadmins do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
