class AddPayKeyToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :pay_key, :string
  end
end
