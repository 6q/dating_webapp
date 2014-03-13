class AddIndexesToTables < ActiveRecord::Migration
  def change
    add_index :users, :deleted_at
    add_index :user_visits, :created_at
    add_index :general_settings, :user_id
    add_index :likes, [ :created_at, :user_id ]
    add_index :likes, [ :creator_id, :user_id ]
    add_index :pictures, [ :attachable_id, :attachable_type, :main ]
  end
end