class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :country, length: 2
      t.string :name
      t.string :region, length: 2
      t.float :latitude
      t.float :longitude
    end
  end
end
