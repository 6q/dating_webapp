class AddBackgroundPreferenceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :background, :integer, default: 1
  end
end
