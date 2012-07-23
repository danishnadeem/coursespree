class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :pwd
      t.string :seed
      t.string :email
      t.string :fName
      t.string :lName
      t.integer :university_id
      t.integer :department_id
      t.integer :year
      t.integer :major_id
      t.text :bio
      t.integer :gender
      t.date :dob
      t.string :paypalEmail
      t.integer :ave_rating
      t.string :fb_ID
      t.integer :active, :default => 0

      t.timestamps
    end
  end
end
