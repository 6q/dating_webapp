class AddAnonymousBrowsingToGeneralSettings < ActiveRecord::Migration
  def change
    add_column :general_settings, :anonymous_browsing, :boolean, default: false
  end
end
