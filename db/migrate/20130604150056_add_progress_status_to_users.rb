class AddProgressStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progress_status, :integer, default: 1
  end
end
