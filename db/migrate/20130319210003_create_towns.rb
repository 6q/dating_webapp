class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.string :name
      t.float :longitude
      t.float :latitude
      t.references :region
      t.references :province

      t.timestamps
    end
  end
end
