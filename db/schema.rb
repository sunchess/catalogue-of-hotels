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

ActiveRecord::Schema.define(:version => 20101101133212) do

  create_table "dynamic_fields", :force => true do |t|
    t.integer "dynamic_model_id"
    t.string  "title"
    t.string  "permalink"
    t.integer "position"
    t.boolean "draft"
  end

  add_index "dynamic_fields", ["dynamic_model_id"], :name => "index_dynamic_fields_on_dynamic_model_id"

  create_table "dynamic_models", :force => true do |t|
    t.string "title"
  end

  create_table "fields_dynamic_fields", :force => true do |t|
    t.integer "dynamic_field_id"
    t.integer "dynamic_id"
    t.string  "dynamic_type"
  end

  add_index "fields_dynamic_fields", ["dynamic_field_id"], :name => "index_fields_dynamic_fields_on_dynamic_field_id"
  add_index "fields_dynamic_fields", ["dynamic_id"], :name => "index_fields_dynamic_fields_on_dynamic_id"
  add_index "fields_dynamic_fields", ["dynamic_type"], :name => "index_fields_dynamic_fields_on_dynamic_type"

  create_table "maps", :force => true do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "zoom"
    t.integer  "mapable_id"
    t.string   "mapable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maps", ["mapable_id"], :name => "index_maps_on_mapable_id"
  add_index "maps", ["mapable_type"], :name => "index_maps_on_mapable_type"

  create_table "places", :force => true do |t|
    t.string   "title"
    t.boolean  "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "position"
  end

  add_index "places", ["parent_id"], :name => "index_places_on_parent_id"
  add_index "places", ["position"], :name => "index_places_on_position"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "role_mask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end