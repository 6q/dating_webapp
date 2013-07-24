class AddDefaultValuesToUserFlags < ActiveRecord::Migration
  def change
    change_column :users, :fake, :boolean, default: false
    change_column :users, :banned, :boolean, default: false
  end
end
