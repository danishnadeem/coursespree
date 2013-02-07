class CreateFreeCodes < ActiveRecord::Migration
  def change
    create_table :free_codes do |t|

      t.integer :user_id
      t.string :code
      t.boolean :is_active, :default => true
      t.timestamps
    end
  end
end
