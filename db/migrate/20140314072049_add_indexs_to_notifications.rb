class AddIndexsToNotifications < ActiveRecord::Migration
  def change
    add_index :cellove_notifications, [ :receiver_id, :seen, :created_at ], :name => 'receiver_seen_created'
  end
end