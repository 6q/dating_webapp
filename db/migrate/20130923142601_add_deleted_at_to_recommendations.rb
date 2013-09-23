class AddDeletedAtToRecommendations < ActiveRecord::Migration
  def change
    add_column :recommendations, :deleted_at, :datetime
  end
end
