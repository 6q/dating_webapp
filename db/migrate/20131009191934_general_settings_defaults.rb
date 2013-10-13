class GeneralSettingsDefaults < ActiveRecord::Migration
  def up
    change_column :general_settings, :like, :boolean, default: true
    change_column :general_settings, :receive_message, :boolean, default: true
    change_column :general_settings, :star_rating, :boolean, default: true
    change_column :general_settings, :celestino_recommendation, :boolean, default: true
    change_column :general_settings, :newsletter, :boolean, default: true
    change_column :general_settings, :user_suggestions, :boolean, default: true
  end

  def down
    change_column :general_settings, :like, :boolean, default: nil
    change_column :general_settings, :receive_message, :boolean, default: nil
    change_column :general_settings, :star_rating, :boolean, default: nil
    change_column :general_settings, :celestino_recommendation, :boolean, default: nil
    change_column :general_settings, :newsletter, :boolean, default: nil
    change_column :general_settings, :user_suggestions, :boolean, default: nil
  end
end
