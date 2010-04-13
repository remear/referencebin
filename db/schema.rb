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

ActiveRecord::Schema.define(:version => 20100413060344) do

  create_table "articles", :force => true do |t|
    t.text     "content"
    t.text     "content_html"
    t.integer  "user_id"
    t.boolean  "published"
    t.boolean  "commentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "permalink"
    t.integer  "language_id"
  end

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
    t.string   "description"
    t.string   "permalink"
    t.integer  "user_id"
    t.integer  "language_id"
    t.string   "thumb_file_name"
    t.string   "thumb_content_type"
    t.string   "thumb_file_size"
    t.datetime "thumb_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookmarks", ["url"], :name => "index_bookmarks_on_url", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
  end

  create_table "flag_categories", :force => true do |t|
    t.string   "description"
    t.string   "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flags", :force => true do |t|
    t.integer  "flaggable_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flaggable_type"
    t.integer  "flag_category_id"
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
    t.string   "name"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["name"], :name => "index_languages_on_name", :unique => true

  create_table "report_caches", :force => true do |t|
    t.string   "model_name",                        :null => false
    t.string   "report_name",                       :null => false
    t.string   "grouping",                          :null => false
    t.string   "aggregation",                       :null => false
    t.float    "value",            :default => 0.0, :null => false
    t.datetime "reporting_period",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "report_caches", ["model_name", "report_name", "grouping", "aggregation", "reporting_period"], :name => "name_model_grouping_aggregation_period", :unique => true
  add_index "report_caches", ["model_name", "report_name", "grouping", "aggregation"], :name => "name_model_grouping_agregation"

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
    t.string   "login",                                  :null => false
    t.string   "email",                                  :null => false
    t.string   "firstname",                              :null => false
    t.string   "lastname",                               :null => false
    t.string   "nickname",                               :null => false
    t.boolean  "admin",               :default => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "landing_page",        :default => 0
    t.boolean  "active"
  end

end
