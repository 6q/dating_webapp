class AddBannedAndFakeFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :banned, :boolean
    add_column :users, :fake, :boolean
  end
end
