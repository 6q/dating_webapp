class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image_uid
      t.string :image_name
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
  end
end
