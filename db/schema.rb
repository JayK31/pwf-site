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

ActiveRecord::Schema.define(:version => 20130728211937) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attendance_sheets", :force => true do |t|
    t.date     "session_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "attendances", :force => true do |t|
    t.integer  "student_registration_id"
    t.integer  "attendance_sheet_id"
    t.date     "session_date"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "attended",                :default => false
  end

  create_table "demographics", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "num_adults"
    t.integer  "num_minors"
    t.integer  "income_range_cd"
    t.integer  "education_level_cd"
    t.integer  "home_ownership_cd"
    t.integer  "season_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "grades", :force => true do |t|
    t.integer  "student_registration_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "report_card_id"
    t.string   "value"
    t.integer  "subject_id"
  end

  create_table "parents", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "payments", :force => true do |t|
    t.decimal  "amount",           :precision => 8, :scale => 2, :default => 1.0
    t.string   "payment_method"
    t.string   "token"
    t.string   "identifier"
    t.string   "payer_id"
    t.boolean  "recurring",                                      :default => false
    t.boolean  "digital",                                        :default => false
    t.boolean  "popup",                                          :default => false
    t.boolean  "completed",                                      :default => false
    t.boolean  "canceled",                                       :default => false
    t.integer  "parent_id"
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.string   "stripe_charge_id"
    t.integer  "method_cd"
    t.integer  "check_no"
    t.integer  "season_id"
  end

  create_table "report_cards", :force => true do |t|
    t.integer  "student_registration_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.integer  "marking_period_type_cd"
    t.integer  "marking_period"
    t.integer  "format_cd"
  end

  create_table "seasons", :force => true do |t|
    t.date     "beg_date"
    t.date     "end_date"
    t.date     "fall_registration_open"
    t.date     "spring_registration_open"
    t.integer  "status_cd"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.boolean  "current"
    t.decimal  "fencing_fee",              :precision => 8, :scale => 2
    t.decimal  "aep_fee",                  :precision => 8, :scale => 2
    t.date     "open_enrollment_date"
    t.string   "message"
  end

  create_table "student_registrations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "season_id"
    t.string   "school"
    t.integer  "grade"
    t.integer  "size_cd"
    t.text     "medical_notes"
    t.text     "academic_notes"
    t.boolean  "academic_assistance"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "status_cd",           :default => 0
    t.integer  "payment_id"
  end

  create_table "students", :force => true do |t|
    t.integer  "parent_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "temp_parents", :force => true do |t|
    t.string  "email"
    t.string  "encrypted_password"
    t.string  "salt"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "address1"
    t.string  "address2"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "primary_phone"
    t.integer "pwf_parent_id"
  end

  create_table "temp_registrations", :force => true do |t|
    t.integer "temp_student_id"
    t.integer "season_id"
    t.integer "grade"
    t.string  "school"
    t.string  "size_cd"
  end

  create_table "temp_students", :force => true do |t|
    t.integer "temp_parent_id"
    t.integer "pwf_parent_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "gender"
    t.date    "dob"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.string   "other_phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean  "admin"
    t.boolean  "parent"
    t.boolean  "tutor"
    t.integer  "profileable_id"
    t.string   "profileable_type"
  end

  add_index "users", ["email"], :name => "index_parents_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_parents_on_reset_password_token", :unique => true

end
