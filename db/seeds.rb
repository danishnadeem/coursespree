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
  :fname => "Danish",
  :lname => "Nadeem",
  :paypalEmail => "cust1_1343182229_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"stud1",
  :password =>"stud1",
  :fname => "first1",
  :lname => "last1",
  :paypalEmail => "cust2_1343352621_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"stud2",
  :password =>"stud2",
  :fname => "first2",
  :lname => "last2",
  :paypalEmail => "cust2_1343352621_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"tutor1",
  :password =>"tutor1",
  :fname => "first3",
  :lname => "last3",
  :paypalEmail => "cust1_1343182229_per@gmail.com",
  :dob => Time.now,
  :university_id => 1
)
User.create(
  :username =>"tutor2",
  :password =>"tutor2",
  :fname => "first4",
  :lname => "last4",
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