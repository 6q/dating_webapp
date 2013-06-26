class DropProvince < ActiveRecord::Migration
  def up
    drop_table :provinces
  end

  def down
    create_table :provinces
  end
end
