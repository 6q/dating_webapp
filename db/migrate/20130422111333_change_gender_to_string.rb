class ChangeGenderToString < ActiveRecord::Migration
  def up
    change_column :users, :gender, :string
  end

  def down
    change_column :users, :gender, :integer
  end
end
