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

ActiveRecord::Schema.define(:version => 20090919031149) do

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

  create_table "languages", :force => true do |t|
    t.string   "name",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",  :limit => 3000
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                    :null => false
    t.string   "email",                                    :null => false
    t.string   "crypted_password",          :limit => 512, :null => false
    t.string   "salt",                      :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 512
    t.datetime "remember_token_expires_at"
    t.string   "nickname"
  end

end
