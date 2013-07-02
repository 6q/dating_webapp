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

ActiveRecord::Schema.define(:version => 20130702160345) do

  create_table "activities", :force => true do |t|
    t.string   "activity_type"
    t.string   "status"
    t.integer  "conversation_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "body"
    t.date     "date"
    t.integer  "sender_id"
  end

  create_table "arrowchat", :force => true do |t|
    t.string  "from",      :limit => 25,                    :null => false
    t.string  "to",        :limit => 25,                    :null => false
    t.text    "message",                                    :null => false
    t.integer "sent",                                       :null => false
    t.integer "read",                                       :null => false
    t.boolean "user_read",               :default => false, :null => false
    t.integer "direction",               :default => 0,     :null => false
  end

  add_index "arrowchat", ["from"], :name => "from"
  add_index "arrowchat", ["read"], :name => "read"
  add_index "arrowchat", ["to"], :name => "to"
  add_index "arrowchat", ["user_read"], :name => "user_read"

  create_table "arrowchat_admin", :force => true do |t|
    t.string "username", :limit => 20, :null => false
    t.string "password", :limit => 50, :null => false
    t.string "email",    :limit => 50, :null => false
  end

  create_table "arrowchat_applications", :force => true do |t|
    t.string  "name",             :limit => 100,                    :null => false
    t.string  "folder",           :limit => 100,                    :null => false
    t.string  "icon",             :limit => 100,                    :null => false
    t.integer "width",                                              :null => false
    t.integer "height",                                             :null => false
    t.integer "bar_width"
    t.string  "bar_name",         :limit => 100
    t.boolean "dont_reload",                     :default => false
    t.boolean "default_bookmark",                :default => true
    t.boolean "show_to_guests",                  :default => true
    t.string  "link"
    t.string  "update_link"
    t.string  "version",          :limit => 20
    t.boolean "active",                          :default => true,  :null => false
  end

  create_table "arrowchat_banlist", :primary_key => "ban_id", :force => true do |t|
    t.string "ban_userid", :limit => 25
    t.string "ban_ip",     :limit => 50
  end

  create_table "arrowchat_chatroom_banlist", :id => false, :force => true do |t|
    t.string  "user_id",     :limit => 25, :null => false
    t.integer "chatroom_id",               :null => false
    t.integer "ban_length",                :null => false
    t.integer "ban_time",                  :null => false
  end

  add_index "arrowchat_chatroom_banlist", ["chatroom_id"], :name => "chatroom_id"
  add_index "arrowchat_chatroom_banlist", ["user_id"], :name => "user_id"

  create_table "arrowchat_chatroom_messages", :force => true do |t|
    t.integer "chatroom_id",                                      :null => false
    t.string  "user_id",        :limit => 25,                     :null => false
    t.string  "username",       :limit => 100,                    :null => false
    t.text    "message",                                          :null => false
    t.boolean "global_message",                :default => false
    t.integer "sent",                                             :null => false
  end

  add_index "arrowchat_chatroom_messages", ["chatroom_id"], :name => "chatroom_id"
  add_index "arrowchat_chatroom_messages", ["sent"], :name => "sent"
  add_index "arrowchat_chatroom_messages", ["user_id"], :name => "user_id"

  create_table "arrowchat_chatroom_rooms", :force => true do |t|
    t.string  "author_id",    :limit => 25,  :null => false
    t.string  "name",         :limit => 100, :null => false
    t.boolean "type",                        :null => false
    t.string  "password",     :limit => 25
    t.integer "length",                      :null => false
    t.integer "session_time",                :null => false
  end

  add_index "arrowchat_chatroom_rooms", ["author_id"], :name => "author_id"
  add_index "arrowchat_chatroom_rooms", ["session_time"], :name => "session_time"

  create_table "arrowchat_chatroom_users", :primary_key => "user_id", :force => true do |t|
    t.integer "chatroom_id",                                  :null => false
    t.boolean "is_admin",                  :default => false, :null => false
    t.boolean "is_mod",                    :default => false, :null => false
    t.integer "block_chats",  :limit => 1, :default => 0,     :null => false
    t.integer "session_time",                                 :null => false
  end

  add_index "arrowchat_chatroom_users", ["chatroom_id"], :name => "chatroom_id"
  add_index "arrowchat_chatroom_users", ["is_admin"], :name => "is_admin"
  add_index "arrowchat_chatroom_users", ["is_mod"], :name => "is_mod"
  add_index "arrowchat_chatroom_users", ["session_time"], :name => "session_time"

  create_table "arrowchat_config", :id => false, :force => true do |t|
    t.string  "config_name",                     :null => false
    t.text    "config_value"
    t.boolean "is_dynamic",   :default => false, :null => false
  end

  add_index "arrowchat_config", ["config_name"], :name => "config_name", :unique => true

  create_table "arrowchat_graph_log", :force => true do |t|
    t.string  "date",               :limit => 30,                :null => false
    t.integer "user_messages",                    :default => 0
    t.integer "chat_room_messages",               :default => 0
  end

  add_index "arrowchat_graph_log", ["date"], :name => "date", :unique => true

  create_table "arrowchat_notifications", :force => true do |t|
    t.string  "to_id",       :limit => 25,                 :null => false
    t.string  "author_id",   :limit => 25,                 :null => false
    t.string  "author_name", :limit => 100,                :null => false
    t.string  "misc1"
    t.string  "misc2"
    t.string  "misc3"
    t.integer "type",                                      :null => false
    t.integer "alert_read",                 :default => 0, :null => false
    t.integer "user_read",                  :default => 0, :null => false
    t.integer "alert_time",                                :null => false
  end

  add_index "arrowchat_notifications", ["alert_read"], :name => "alert_read"
  add_index "arrowchat_notifications", ["alert_time"], :name => "alert_time"
  add_index "arrowchat_notifications", ["to_id"], :name => "to_id"
  add_index "arrowchat_notifications", ["user_read"], :name => "user_read"

  create_table "arrowchat_notifications_markup", :force => true do |t|
    t.string  "name",   :limit => 50, :null => false
    t.integer "type",                 :null => false
    t.text    "markup",               :null => false
  end

  create_table "arrowchat_smilies", :force => true do |t|
    t.string "name", :limit => 20, :null => false
    t.string "code", :limit => 10, :null => false
  end

  create_table "arrowchat_status", :primary_key => "userid", :force => true do |t|
    t.string  "guest_name",           :limit => 50
    t.text    "message"
    t.string  "status",               :limit => 10
    t.integer "theme"
    t.integer "popout"
    t.text    "typing"
    t.boolean "hide_bar"
    t.boolean "play_sound",                         :default => true
    t.boolean "window_open"
    t.boolean "only_names"
    t.string  "chatroom_window",      :limit => 2,  :default => "-1",  :null => false
    t.string  "chatroom_stay",        :limit => 2,  :default => "-1",  :null => false
    t.boolean "chatroom_block_chats"
    t.boolean "chatroom_sound"
    t.boolean "announcement",                       :default => true,  :null => false
    t.text    "unfocus_chat"
    t.string  "focus_chat",           :limit => 20
    t.text    "last_message"
    t.text    "apps_bookmarks"
    t.text    "apps_other"
    t.integer "apps_open"
    t.text    "block_chats"
    t.integer "session_time",                                          :null => false
    t.boolean "is_admin",                           :default => false, :null => false
    t.string  "hash_id",              :limit => 20,                    :null => false
  end

  add_index "arrowchat_status", ["hash_id"], :name => "hash_id"
  add_index "arrowchat_status", ["session_time"], :name => "session_time"

  create_table "arrowchat_themes", :force => true do |t|
    t.string  "folder",      :limit => 25,  :null => false
    t.string  "name",        :limit => 100, :null => false
    t.boolean "active",                     :null => false
    t.string  "update_link"
    t.string  "version",     :limit => 20
    t.boolean "default",                    :null => false
  end

  create_table "arrowchat_trayicons", :force => true do |t|
    t.string  "name",          :limit => 100,                   :null => false
    t.string  "icon",          :limit => 100,                   :null => false
    t.string  "location",                                       :null => false
    t.string  "target",        :limit => 25
    t.integer "width"
    t.integer "height"
    t.integer "tray_width"
    t.string  "tray_name",     :limit => 100
    t.integer "tray_location",                                  :null => false
    t.boolean "active",                       :default => true, :null => false
  end

  create_table "cellove_notifications", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.boolean  "seen",            :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "characteristics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "romantic",          :default => 3, :null => false
    t.integer  "adventurer",        :default => 3, :null => false
    t.integer  "friendly",          :default => 3, :null => false
    t.integer  "familiar",          :default => 3, :null => false
    t.integer  "hardWorking",       :default => 3, :null => false
    t.integer  "extroverted",       :default => 3, :null => false
    t.integer  "generous",          :default => 3, :null => false
    t.integer  "reserved",          :default => 3, :null => false
    t.integer  "sociable",          :default => 3, :null => false
    t.integer  "quiet",             :default => 3, :null => false
    t.integer  "demanding",         :default => 3, :null => false
    t.integer  "prideful",          :default => 3, :null => false
    t.integer  "solitary",          :default => 3, :null => false
    t.integer  "tenacious",         :default => 3, :null => false
    t.integer  "attentive",         :default => 3, :null => false
    t.integer  "goodHumored",       :default => 3, :null => false
    t.integer  "spontaneous",       :default => 3, :null => false
    t.integer  "restless",          :default => 3, :null => false
    t.integer  "sensitive",         :default => 3, :null => false
    t.integer  "shy",               :default => 3, :null => false
    t.integer  "possessive",        :default => 3, :null => false
    t.integer  "jealous",           :default => 3, :null => false
    t.integer  "faithful",          :default => 3, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "recommendation_id"
  end

  create_table "cities", :force => true do |t|
    t.string "country"
    t.string "name"
    t.string "region"
    t.float  "latitude"
    t.float  "longitude"
  end

  add_index "cities", ["country"], :name => "index_cities_on_country"
  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "general_settings", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "no_email_online",              :default => true
    t.boolean  "profile_visit",                :default => true
    t.boolean  "receive_message"
    t.boolean  "like"
    t.boolean  "star_rating"
    t.boolean  "celestino_recommendation"
    t.boolean  "newsletter"
    t.boolean  "user_suggestions"
    t.boolean  "new_users_nearby"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "show_online",                  :default => true
    t.boolean  "allow_chat"
    t.boolean  "show_only_nearby"
    t.boolean  "show_only_matching_profiles"
    t.boolean  "show_only_people_who_like_me"
    t.boolean  "show_only_buena_pareja"
    t.boolean  "show_only_pm"
    t.boolean  "show_only_rated_me"
    t.boolean  "anonymous_browsing",           :default => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "invitor_id"
    t.string   "invited_email"
    t.boolean  "accepted",        :default => false
    t.string   "invitation_code"
    t.string   "user_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "creator_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "evaluated_id"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.float    "stars",       :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "rates", ["rateable_id"], :name => "index_rates_on_rateable_id"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

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

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "relationship"
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "confirmed",    :default => false
    t.boolean  "denied",       :default => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
    t.string   "country"
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

  create_table "searches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "years_lteq"
    t.integer  "years_gteq"
    t.string   "town_eq"
    t.string   "postal_code_cont"
    t.string   "description_cont"
    t.boolean  "pictures_main_eq"
    t.integer  "distance"
    t.string   "sort"
    t.boolean  "online"
    t.string   "smoker_in"
    t.string   "children_in"
    t.integer  "height_lteq"
    t.integer  "height_gteq"
    t.integer  "afinity_eq"
    t.string   "complexion_eq"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
  end

  create_table "towns", :force => true do |t|
    t.string   "name"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "region_id"
    t.integer  "province_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_blocks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blocked_user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "user_blocks", ["blocked_user_id"], :name => "index_user_blocks_on_blocked_user_id"

  create_table "user_hides", :force => true do |t|
    t.integer  "user_id"
    t.integer  "hidden_user_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "user_hides", ["hidden_user_id"], :name => "index_user_hides_on_hidden_user_id"

  create_table "user_visits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "visitor_id"
    t.datetime "visited_at"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "seen",       :default => false
  end

  add_index "user_visits", ["user_id"], :name => "index_user_visits_on_user_id"
  add_index "user_visits", ["visitor_id"], :name => "index_user_visits_on_visitor_id"

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
    t.string   "city"
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
    t.string   "lf_smoke"
    t.string   "lf_diet"
    t.string   "lf_alcohol"
    t.string   "lf_religion"
    t.string   "lf_study_level"
    t.string   "lf_language"
    t.string   "lf_job"
    t.string   "lf_salary"
    t.text     "house"
    t.text     "eyes"
    t.text     "hair"
    t.text     "hair_style"
    t.text     "citizenship"
    t.text     "ethnicity"
    t.text     "language_level"
    t.text     "wedding_opinion"
    t.text     "music_genre"
    t.text     "cinema_frequency"
    t.text     "cinema_genre"
    t.boolean  "like_sport"
    t.boolean  "like_read"
    t.boolean  "like_cinema"
    t.boolean  "like_quiet"
    t.boolean  "like_walk"
    t.boolean  "like_mountain"
    t.boolean  "like_beach"
    t.boolean  "like_family"
    t.boolean  "like_friends"
    t.text     "religion_activity"
    t.string   "invitation_code"
    t.text     "lf_house"
    t.text     "lf_hair"
    t.text     "lf_hair_style"
    t.text     "lf_eyes"
    t.boolean  "lf_like_sport"
    t.boolean  "lf_like_read"
    t.boolean  "lf_like_cinema"
    t.boolean  "lf_like_quiet"
    t.boolean  "lf_like_walk"
    t.boolean  "lf_like_mountain"
    t.boolean  "lf_like_beach"
    t.boolean  "lf_like_family"
    t.boolean  "lf_like_friends"
    t.text     "lf_religion_activity"
    t.text     "lf_citizenship"
    t.text     "lf_ethnicity"
    t.text     "lf_animals"
    t.text     "lf_party"
    t.text     "lf_language_level"
    t.integer  "cellove_index",          :default => 0
    t.string   "lf_relationship"
    t.integer  "background",             :default => 1
    t.integer  "progress_status",        :default => 1
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "seeking"
  end

  add_index "users", ["cellove_index"], :name => "index_users_on_cellove_index"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_code"], :name => "index_users_on_invitation_code", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

end
