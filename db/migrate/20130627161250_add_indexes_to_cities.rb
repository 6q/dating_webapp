class AddIndexesToCities < ActiveRecord::Migration
  def change
    add_index(:cities, :country)
    add_index(:cities, :name)
  end
end
