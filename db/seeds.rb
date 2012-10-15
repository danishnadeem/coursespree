# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.create(
  :username =>"admin",
  :password =>"coursespree",
  :fName => "Danish",
  :lName => "Nadeem",
  :paypalEmail => "cust1_1343182229_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"stud1",
  :password =>"stud1",
  :fName => "first1",
  :lName => "last1",
  :paypalEmail => "cust2_1343352621_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"stud2",
  :password =>"stud2",
  :fName => "first2",
  :lName => "last2",
  :paypalEmail => "cust2_1343352621_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"tutor1",
  :password =>"tutor1",
  :fName => "first3",
  :lName => "last3",
  :paypalEmail => "cust1_1343182229_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"tutor2",
  :password =>"tutor2",
  :fName => "first4",
  :lName => "last4",
  :paypalEmail => "cust1_1343182229_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
Tutor.create(
  :user_id => User.find_by_username("tutor1"),
  :approved => 1
)
Tutor.create(
  :user_id => User.find_by_username("tutor2"),
  :approved => 1
)
Superadmin.create(:user_id=> 1)

University.create(
  :name => "syracuse university"
)