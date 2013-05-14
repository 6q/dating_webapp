class AddRecommendationIdToCharacteristics < ActiveRecord::Migration
  def change
    add_column :characteristics, :recommendation_id, :integer
  end
end
