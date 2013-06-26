class RenameUserFields < ActiveRecord::Migration
  def up
    rename_column :users, :town, :city
  end

  def down
    rename_column :users, :city, :town
  end
end
