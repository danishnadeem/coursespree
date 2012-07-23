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

ActiveRecord::Schema.define(:version => 20120723131023) do

  create_table "meetings", :force => true do |t|
    t.string   "name"
    t.string   "attendeePW"
    t.string   "moderatorPW"
    t.string   "duration"
    t.string   "classlink"
    t.string   "subject"
    t.datetime "start_time"
    t.integer  "tutor_id"
    t.integer  "user_id"
    t.float    "price"
    t.integer  "rating"
    t.integer  "accept",      :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "status"
    t.text     "message"
    t.boolean  "paid",        :default => false
    t.datetime "trandate"
  end

  create_table "subjects", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects_tutors", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "tutor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "superadmins", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tutor_availabilities", :force => true do |t|
    t.integer  "tutor_id"
    t.integer  "dayofweek"
    t.datetime "start_time"
    t.integer  "length"
    t.integer  "weeksche_mark"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tutors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "approved",                                              :default => 0
    t.datetime "created_at",                                                             :null => false
    t.datetime "updated_at",                                                             :null => false
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.string   "transcript_file_name"
    t.string   "transcript_content_type"
    t.integer  "transcript_file_size"
    t.datetime "transcript_updated_at"
    t.decimal  "rate",                    :precision => 5, :scale => 2, :default => 0.0
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "pwd"
    t.string   "seed"
    t.string   "email"
    t.string   "fName"
    t.string   "lName"
    t.integer  "university_id"
    t.integer  "department_id"
    t.integer  "year"
    t.integer  "major_id"
    t.text     "bio"
    t.integer  "gender"
    t.date     "dob"
    t.string   "paypalEmail"
    t.integer  "ave_rating"
    t.string   "fb_ID"
    t.integer  "active",              :default => 0
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
