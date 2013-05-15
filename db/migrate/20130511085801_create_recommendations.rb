class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :creator_id
      t.integer :relationship
      t.text :description

      t.timestamps
    end
  end
end
