class MakeUserTownAString < ActiveRecord::Migration
  def up
    change_column(:users, :town, :string)
  end

  def down
    change_column(:user, :town, :integer)
  end
end
