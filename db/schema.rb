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

ActiveRecord::Schema.define(:version => 20110405163733) do

  create_table "accepts", :force => true do |t|
    t.integer  "offer_id"
    t.integer  "user_id"
    t.integer  "status",            :default => 0,   :null => false
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.text     "list_tourists"
    t.integer  "all_tourists"
    t.date     "coming_on"
    t.date     "outing_on"
    t.float    "cost",              :default => 0.0, :null => false
    t.integer  "discount",          :default => 0,   :null => false
    t.float    "discount_sum",      :default => 0.0, :null => false
    t.float    "min_prepayment",    :default => 0.0, :null => false
    t.float    "sum_with_discount", :default => 0.0, :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accepts", ["offer_id"], :name => "index_accepts_on_offer_id"
  add_index "accepts", ["status"], :name => "index_accepts_on_status"
  add_index "accepts", ["user_id"], :name => "index_accepts_on_user_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "articleable_id"
    t.string   "articleable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "images_count",     :default => 0, :null => false
  end

  add_index "articles", ["articleable_id"], :name => "index_articles_on_articleable_id"
  add_index "articles", ["articleable_type"], :name => "index_articles_on_articleable_type"

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

  create_table "hotels", :force => true do |t|
    t.integer  "place_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "street"
    t.string   "house_number"
    t.text     "telephone"
    t.string   "fax"
    t.integer  "distance"
    t.boolean  "draft",                 :default => true,  :null => false
    t.boolean  "paid_placement",        :default => false, :null => false
    t.text     "banking_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "images_count",          :default => 0,     :null => false
    t.boolean  "confirmed",             :default => false, :null => false
    t.string   "contract_file_name"
    t.string   "contract_content_type"
    t.integer  "contract_file_size"
    t.string   "site"
    t.string   "email"
    t.integer  "position"
  end

  add_index "hotels", ["place_id"], :name => "index_hotels_on_place_id"
  add_index "hotels", ["user_id"], :name => "index_hotels_on_user_id"

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.boolean  "draft",              :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["imageable_id", "imageable_type"], :name => "index_images_on_imageable_id_and_imageable_type"

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

  create_table "offer_agents", :force => true do |t|
    t.string   "name"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", :force => true do |t|
    t.integer  "offer_agent_id"
    t.string   "name"
    t.text     "body"
    t.float    "price",                             :null => false
    t.integer  "fee",                               :null => false
    t.integer  "discount"
    t.integer  "images_count"
    t.integer  "position"
    t.boolean  "ad",             :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["offer_agent_id"], :name => "index_offers_on_offer_agent_id"
  add_index "offers", ["price"], :name => "index_offers_on_price"

  create_table "places", :force => true do |t|
    t.string   "title"
    t.boolean  "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "position"
    t.integer  "images_count",   :default => 0, :null => false
    t.integer  "articles_count", :default => 0, :null => false
  end

  add_index "places", ["parent_id"], :name => "index_places_on_parent_id"
  add_index "places", ["position"], :name => "index_places_on_position"

  create_table "prices", :force => true do |t|
    t.integer  "room_id"
    t.integer  "month"
    t.integer  "cost"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fee",        :default => 20, :null => false
    t.integer  "discount",   :default => 5,  :null => false
  end

  add_index "prices", ["room_id"], :name => "index_prices_on_room_id"

  create_table "reserves", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status",            :default => 0,   :null => false
    t.string   "name"
    t.string   "address"
    t.string   "telephone"
    t.text     "list_tourists"
    t.date     "coming_on"
    t.date     "outing_on"
    t.float    "cost",              :default => 0.0, :null => false
    t.integer  "discount",          :default => 0,   :null => false
    t.float    "discount_sum",      :default => 0.0, :null => false
    t.float    "min_prepayment",    :default => 0.0, :null => false
    t.float    "sum_with_discount", :default => 0.0, :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "orderable_id"
    t.string   "orderable_type"
    t.integer  "all_tourists"
  end

  add_index "reserves", ["orderable_id"], :name => "index_reserves_on_orderable_id"
  add_index "reserves", ["orderable_type"], :name => "index_reserves_on_orderable_type"
  add_index "reserves", ["status"], :name => "index_reserves_on_status"
  add_index "reserves", ["user_id"], :name => "index_reserves_on_user_id"

  create_table "rooms", :force => true do |t|
    t.integer  "hotel_id"
    t.integer  "places"
    t.integer  "room_number"
    t.integer  "shower"
    t.integer  "toilet"
    t.integer  "fridge"
    t.integer  "tv"
    t.integer  "images_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.boolean  "ad",           :default => false
  end

  add_index "rooms", ["hotel_id"], :name => "index_rooms_on_hotel_id"

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
