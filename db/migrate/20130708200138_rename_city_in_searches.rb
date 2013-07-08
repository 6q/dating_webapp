class RenameCityInSearches < ActiveRecord::Migration
  def up
    rename_column :searches, :town_eq, :city_eq
  end

  def down
    rename_column :searches, :city_eq, :town_eq
  end
end
