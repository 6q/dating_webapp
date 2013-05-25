class AddCelloveIndexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cellove_index, :integer, :default => 0
    add_index :users, :cellove_index
  end
end
