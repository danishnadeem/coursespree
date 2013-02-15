# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130215064019) do

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "free_codes", :force => true do |t|
    t.integer   "user_id"
    t.string    "code"
    t.boolean   "is_active",  :default => true
    t.timestamp "created_at",                   :null => false
    t.timestamp "updated_at",                   :null => false
  end

  create_table "meetings", :force => true do |t|
    t.string    "name"
    t.string    "attendeePW"
    t.string    "moderatorPW"
    t.integer   "tutor_id"
    t.integer   "user_id"
    t.float     "price"
    t.integer   "rating"
    t.integer   "accept",                :default => 0
    t.timestamp "created_at",                               :null => false
    t.timestamp "updated_at",                               :null => false
    t.integer   "status"
    t.text      "message"
    t.boolean   "paid",                  :default => false
    t.timestamp "trandate"
    t.integer   "tutor_availability_id"
    t.string    "paykey"
    t.integer   "location_id"
    t.integer   "subject_id"
    t.boolean   "has_code",              :default => false
  end

  create_table "subadmins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string    "title"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "subjects_tutors", :force => true do |t|
    t.integer   "subject_id"
    t.integer   "tutor_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "superadmins", :force => true do |t|
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "tutor_id"
    t.integer  "user_id"
    t.float    "amount"
    t.integer  "meeting_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "pay_key"
  end

  create_table "tutor_availabilities", :force => true do |t|
    t.integer   "tutor_id"
    t.timestamp "start_time"
    t.integer   "length"
    t.timestamp "created_at",                :null => false
    t.timestamp "updated_at",                :null => false
    t.integer   "taken",      :default => 0
    t.integer   "timetype"
  end

  create_table "tutor_locations", :force => true do |t|
    t.string    "name"
    t.integer   "university_id"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  create_table "tutors", :force => true do |t|
    t.integer   "user_id"
    t.integer   "approved",                :default => 0
    t.timestamp "created_at",                               :null => false
    t.timestamp "updated_at",                               :null => false
    t.string    "resume_file_name"
    t.string    "resume_content_type"
    t.integer   "resume_file_size"
    t.timestamp "resume_updated_at"
    t.string    "transcript_file_name"
    t.string    "transcript_content_type"
    t.integer   "transcript_file_size"
    t.timestamp "transcript_updated_at"
    t.decimal   "rate",                    :default => 0.0
  end

  create_table "universities", :force => true do |t|
    t.string    "name"
    t.string    "note"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "username"
    t.string    "pwd"
    t.string    "seed"
    t.string    "email"
    t.string    "fName"
    t.string    "lName"
    t.integer   "university_id"
    t.integer   "department_id"
    t.integer   "year"
    t.integer   "major_id"
    t.text      "bio"
    t.integer   "gender"
    t.date      "dob"
    t.string    "paypalEmail"
    t.integer   "ave_rating"
    t.string    "fb_ID"
    t.integer   "active",              :default => 0
    t.timestamp "created_at",                         :null => false
    t.timestamp "updated_at",                         :null => false
    t.string    "avatar_file_name"
    t.string    "avatar_content_type"
    t.integer   "avatar_file_size"
    t.timestamp "avatar_updated_at"
    t.string    "fb_uid"
    t.string    "fb_token"
    t.timestamp "fb_token_expire"
  end

end
