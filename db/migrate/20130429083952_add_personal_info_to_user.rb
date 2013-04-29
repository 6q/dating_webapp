class AddPersonalInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :hobbies, :text
    add_column :users, :party, :text
    add_column :users, :music, :text
    add_column :users, :cinema, :text
  end
end
