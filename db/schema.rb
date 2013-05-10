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

ActiveRecord::Schema.define(:version => 20130509094156) do

  create_table "activities", :force => true do |t|
    t.string   "activity_type"
    t.string   "status"
    t.integer  "conversation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "body"
    t.date     "date"
  end

  create_table "characteristics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "romantic",    :default => 3, :null => false
    t.integer  "adventurer",  :default => 3, :null => false
    t.integer  "friendly",    :default => 3, :null => false
    t.integer  "familiar",    :default => 3, :null => false
    t.integer  "hardWorking", :default => 3, :null => false
    t.integer  "extroverted", :default => 3, :null => false
    t.integer  "generous",    :default => 3, :null => false
    t.integer  "reserved",    :default => 3, :null => false
    t.integer  "sociable",    :default => 3, :null => false
    t.integer  "quiet",       :default => 3, :null => false
    t.integer  "demanding",   :default => 3, :null => false
    t.integer  "prideful",    :default => 3, :null => false
    t.integer  "solitary",    :default => 3, :null => false
    t.integer  "tenacious",   :default => 3, :null => false
    t.integer  "attentive",   :default => 3, :null => false
    t.integer  "goodHumored", :default => 3, :null => false
    t.integer  "spontaneous", :default => 3, :null => false
    t.integer  "restless",    :default => 3, :null => false
    t.integer  "sensitive",   :default => 3, :null => false
    t.integer  "shy",         :default => 3, :null => false
    t.integer  "possessive",  :default => 3, :null => false
    t.integer  "jealous",     :default => 3, :null => false
    t.integer  "faithful",    :default => 3, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

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

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

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
    t.string   "smoke"
    t.string   "diet"
    t.string   "alcohol"
    t.string   "religion"
    t.string   "animals"
    t.string   "study_level"
    t.string   "language"
    t.string   "job"
    t.string   "salary"
    t.string   "description"
    t.text     "party"
    t.text     "music"
    t.text     "cinema"
    t.string   "lf_gender"
    t.string   "lf_orientation"
    t.string   "lf_marital_status"
    t.string   "lf_age_between"
    t.string   "lf_age_to"
    t.string   "lf_city"
    t.string   "lf_country"
    t.string   "lf_postal_code"
    t.string   "lf_physical_style"
    t.string   "lf_physical_desc"
    t.integer  "lf_height_between"
    t.integer  "lf_height_to"
    t.integer  "lf_weight_between"
    t.integer  "lf_weight_to"
    t.string   "lf_complexion"
    t.string   "lf_child"
    t.string   "lf_child_want"
    t.string   "lf_smoke"
    t.string   "lf_smoke_tolerance"
    t.string   "lf_diet"
    t.string   "lf_alcohol"
    t.string   "lf_drugs"
    t.string   "lf_drug_frequency"
    t.string   "lf_religion"
    t.string   "lf_religion_opinion"
    t.string   "lf_animal_like"
    t.string   "lf_animal_have"
    t.string   "lf_study_level"
    t.string   "lf_language"
    t.string   "lf_job"
    t.string   "lf_salary"
    t.string   "lf_description"
    t.string   "house"
    t.string   "eyes"
    t.string   "hair"
    t.string   "hair_style"
    t.string   "citizenship"
    t.string   "ethnicity"
    t.string   "language_level"
    t.string   "wedding_opinion"
    t.string   "music_genre"
    t.string   "cinema_frequency"
    t.string   "cinema_genre"
    t.string   "like_sport"
    t.string   "like_read"
    t.string   "like_cinema"
    t.string   "like_quiet"
    t.string   "like_walk"
    t.string   "like_mountain"
    t.string   "like_beach"
    t.string   "like_family"
    t.string   "like_friends"
    t.string   "religion_activity"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
