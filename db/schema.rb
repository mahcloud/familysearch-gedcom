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

ActiveRecord::Schema.define(:version => 20130207210139) do

  create_table "ancestry_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "password"
    t.string   "session_id"
    t.datetime "session_update"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "family_search_accounts", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.string   "username",       :null => false
    t.string   "password",       :null => false
    t.string   "session_id"
    t.datetime "session_update"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "family_search_accounts", ["user_id"], :name => "index_family_search_users_on_user_id", :unique => true

  create_table "people", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.string   "gender"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_events", :force => true do |t|
    t.integer  "person_id"
    t.string   "type"
    t.datetime "date"
    t.string   "place"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_family_search_identifier", :force => true do |t|
    t.integer  "person_id"
    t.string   "family_search_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.string   "password",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
