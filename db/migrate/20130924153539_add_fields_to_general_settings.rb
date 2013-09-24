class AddFieldsToGeneralSettings < ActiveRecord::Migration
  def change
    add_column :general_settings, :receive_messages_only_from_likes, :boolean, default: false
    add_column :general_settings, :allow_chat_only_from_likes, :boolean, default: false
    add_column :general_settings, :age_restriction, :boolean, default: true
  end
end
