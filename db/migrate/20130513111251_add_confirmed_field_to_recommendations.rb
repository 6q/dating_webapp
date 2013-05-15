class AddConfirmedFieldToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :confirmed, :boolean, default: false
  end
end
