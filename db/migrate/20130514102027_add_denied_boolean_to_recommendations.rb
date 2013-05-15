class AddDeniedBooleanToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :denied, :boolean, default: false
  end
end
