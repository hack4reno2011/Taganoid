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

ActiveRecord::Schema.define(:version => 20111015225432) do

  create_table "entries", :force => true do |t|
    t.integer  "entry_type_id",  :null => false
    t.integer  "status_id",      :null => false
    t.integer  "group_id",       :null => false
    t.string   "title",          :null => false
    t.text     "descr"
    t.text     "image_url"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "creator_name"
    t.string   "creator_number"
    t.datetime "created_at"
  end

  add_index "entries", ["created_at"], :name => "index_entries_on_created_at"
  add_index "entries", ["creator_name"], :name => "index_entries_on_creator_name"
  add_index "entries", ["creator_number"], :name => "index_entries_on_creator_number"
  add_index "entries", ["entry_type_id"], :name => "index_entries_on_entry_type_id"
  add_index "entries", ["group_id"], :name => "index_entries_on_group_id"
  add_index "entries", ["latitude"], :name => "index_entries_on_latitude"
  add_index "entries", ["longitude"], :name => "index_entries_on_longitude"
  add_index "entries", ["status_id"], :name => "index_entries_on_status_id"

  create_table "entry_types", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string "name", :null => false
  end

end
