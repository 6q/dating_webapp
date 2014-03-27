class AddInvisibleToUserVisits < ActiveRecord::Migration
  def change
    add_column :user_visits, :invisible, :boolean, default: false
  end
end
