class AddIndexsToNotifications < ActiveRecord::Migration
  def change
    add_index :cellove_notifications, [ :receiver_id, :seen, :created_at ]
  end
end