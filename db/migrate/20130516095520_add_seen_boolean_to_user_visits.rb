class AddSeenBooleanToUserVisits < ActiveRecord::Migration
  def change
    add_column :user_visits, :seen, :boolean, default: false
  end
end
