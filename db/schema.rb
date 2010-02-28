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

ActiveRecord::Schema.define(:version => 20100228193359) do

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_item_id", :null => false
    t.integer  "user_id",      :null => false
    t.text     "body",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "active",       :null => false
  end

  create_table "blog_items", :force => true do |t|
    t.string   "title",                                 :null => false
    t.text     "body",                                  :null => false
    t.integer  "user_id",                               :null => false
    t.integer  "blog_item_photo_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "active",                                :null => false
    t.integer  "icon_id"
    t.boolean  "public",             :default => false, :null => false
  end

  create_table "icons", :force => true do |t|
    t.string   "name"
    t.string   "image_file_name",    :null => false
    t.string   "image_content_type", :null => false
    t.integer  "image_file_size",    :null => false
    t.datetime "image_updated_at",   :null => false
  end

  create_table "photo_sets", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  add_index "photo_sets", ["name"], :name => "unique_name", :unique => true

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "photo_set_id"
    t.string   "image_file_name",    :null => false
    t.string   "image_content_type", :null => false
    t.integer  "image_file_size",    :null => false
    t.datetime "image_updated_at",   :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login",                                   :null => false
    t.integer  "role_id",                                 :null => false
    t.string   "email",                                   :null => false
    t.string   "crypted_password",          :limit => 40, :null => false
    t.string   "salt",                      :limit => 40, :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "firstname",                               :null => false
    t.string   "lastname",                                :null => false
    t.boolean  "active",                                  :null => false
    t.string   "timezone"
  end

end
