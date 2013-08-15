class AddSeenToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :seen, :boolean, default: false
  end
end
