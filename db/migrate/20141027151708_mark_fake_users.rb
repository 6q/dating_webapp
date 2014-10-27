class MarkFakeUsers < ActiveRecord::Migration
  def up
    execute "update users set fake = true, updated_at='#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")}' WHERE  `email` LIKE  '%xxx.xx'" 
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
