class AddMainFlagToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :main, :boolean, default: false
  end
end
