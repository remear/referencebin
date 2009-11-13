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

ActiveRecord::Schema.define(:version => 20091109000018) do

  create_table "bookmark_imports", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "user_id"
    t.string   "description"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "permalink",          :limit => 3000
    t.string   "description",        :limit => 3000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
    t.integer  "user_id"
    t.string   "thumb_file_name"
    t.string   "thumb_content_type"
    t.integer  "thumb_file_size"
    t.datetime "thumb_updated_at"
  end

  add_index "bookmarks", ["url"], :name => "index_bookmarks_on_url", :unique => true

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
    t.integer  "language_id"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jots", :force => true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.boolean  "private",     :default => false
    t.text     "code"
    t.text     "error"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", :force => true do |t|
    t.string   "name",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",  :limit => 3000
  end

  add_index "languages", ["name"], :name => "index_languages_on_name", :unique => true

  create_table "questions", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "bookmark_id"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40,                         :null => false
    t.string   "firstname",                 :limit => 100,                        :null => false
    t.string   "lastname",                  :limit => 100,                        :null => false
    t.string   "nickname",                  :limit => 100,                        :null => false
    t.string   "email",                     :limit => 100,                        :null => false
    t.boolean  "description"
    t.boolean  "contributor",                              :default => false
    t.boolean  "admin",                                    :default => false
    t.string   "crypted_password",          :limit => 512
    t.string   "salt",                      :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 512
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 512
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.integer  "landing_page",                             :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
