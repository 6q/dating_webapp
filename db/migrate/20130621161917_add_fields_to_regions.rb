class AddFieldsToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :code, :string, lenght: 2
    add_column :regions, :country, :string, lenght: 2
  end
end
