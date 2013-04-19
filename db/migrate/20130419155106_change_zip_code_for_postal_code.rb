class ChangeZipCodeForPostalCode < ActiveRecord::Migration
  def up
    rename_column :users, :zip_code, :postal_code
  end

  def down
    rename_column :users, :postal_code, :zip_code
  end
end
