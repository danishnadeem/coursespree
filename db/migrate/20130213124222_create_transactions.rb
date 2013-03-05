class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :tutor_id
      t.integer :user_id
      t.float :amount
      t.integer :meeting_id

      t.timestamps
    end
  end
end