class UpdateGeneralSetting < ActiveRecord::Migration
  def up
    add_column :general_settings, :show_online, :boolean, default: true
    add_column :general_settings, :allow_chat, :boolean
    add_column :general_settings, :show_only_nearby, :boolean
    add_column :general_settings, :show_only_matching_profiles, :boolean
    add_column :general_settings, :show_only_people_who_like_me, :boolean
    add_column :general_settings, :show_only_buena_pareja, :boolean
    add_column :general_settings, :show_only_pm, :boolean
    add_column :general_settings, :show_only_rated_me, :boolean
  end

  def down
    remove_column :general_settings, :show_online
    remove_column :general_settings, :allow_chat
    remove_column :general_settings, :show_only_nearby
    remove_column :general_settings, :show_only_matching_profiles
    remove_column :general_settings, :show_only_people_who_like_me
    remove_column :general_settings, :show_only_buena_pareja
    remove_column :general_settings, :show_only_pm
    remove_column :general_settings, :show_only_rated_me
  end
end
