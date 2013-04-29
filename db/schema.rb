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

ActiveRecord::Schema.define(:version => 20130429083952) do

  create_table "pictures", :force => true do |t|
    t.string   "image_uid"
    t.string   "image_name"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "main",            :default => false
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "towns", :force => true do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "region_id"
    t.integer  "province_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "surname"
    t.string   "screen_name"
    t.string   "gender"
    t.string   "orientation"
    t.string   "marital_status"
    t.date     "birth_date"
    t.string   "postal_code"
    t.string   "town"
    t.string   "country"
    t.boolean  "newsletter_optin"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "physical_style"
    t.string   "physical_desc"
    t.integer  "height"
    t.integer  "weight"
    t.string   "complexion"
    t.string   "child"
    t.string   "child_want"
    t.string   "smoke"
    t.string   "smoke_tolerance"
    t.string   "diet"
    t.string   "alcohol"
    t.string   "drugs"
    t.string   "drug_frequency"
    t.string   "religion"
    t.string   "religion_opinion"
    t.string   "animal_like"
    t.string   "animal_have"
    t.string   "study_level"
    t.string   "language"
    t.string   "job"
    t.string   "salary"
    t.string   "description"
    t.text     "hobbies"
    t.text     "party"
    t.text     "music"
    t.text     "cinema"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
