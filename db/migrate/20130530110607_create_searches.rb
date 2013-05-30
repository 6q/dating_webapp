class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :user_id
      t.integer :years_lteq
      t.integer :years_gteq
      t.string :town_eq
      t.string :postal_code_cont
      t.string :description_cont
      t.boolean :pictures_main_eq
      t.integer :distance
      t.string :sort
      t.boolean :online
      t.string :smoker_in
      t.string :children_in
      t.integer :height_lteq
      t.integer :height_gteq
      t.integer :afinity_eq
      t.string :complexion_eq

      t.timestamps
    end
  end
end
