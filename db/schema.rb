# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090923184732) do

  create_table "bookmarks", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "permalink",   :limit => 3000
    t.string   "description", :limit => 3000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id", :null => false
  end

  create_table "codes", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
  end

  create_table "comments", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bookmark_id"
    t.integer  "user_id"
    t.string   "importance"
    t.text     "code"
    t.integer  "language_id"
  end

  create_table "languages", :force => true do |t|
    t.string   "name",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",  :limit => 3000
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 512
    t.string   "salt",                      :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 512
    t.datetime "remember_token_expires_at"
    t.string   "profile_file_name"
    t.string   "profile_content_type"
    t.integer  "profile_file_size"
    t.string   "nickname"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
