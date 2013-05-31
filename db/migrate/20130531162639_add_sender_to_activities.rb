class AddSenderToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :sender_id, :integer
  end
end
