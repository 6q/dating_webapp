class AddIndicesToTables < ActiveRecord::Migration
  def change
    add_index :users, :invitation_code, :unique => true
    add_index :user_blocks, :blocked_user_id
    add_index :user_hides, :hidden_user_id
    add_index :users, :created_at
    add_index :user_visits, :visitor_id
    add_index :user_visits, :user_id
  end
end
