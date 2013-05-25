class CreateCelloveNotifications < ActiveRecord::Migration
  def change
    create_table :cellove_notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :notifiable_id
      t.string :notifiable_type
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
