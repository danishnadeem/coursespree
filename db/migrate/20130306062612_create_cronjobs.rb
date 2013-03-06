class CreateCronjobs < ActiveRecord::Migration
  def change
    create_table :cronjobs do |t|

      t.timestamps
    end
  end
end
