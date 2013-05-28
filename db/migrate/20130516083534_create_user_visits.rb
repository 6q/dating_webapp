class CreateUserVisits < ActiveRecord::Migration
  def change
    create_table :user_visits do |t|
      t.integer :user_id
      t.integer :visitor_id
      t.datetime :visited_at

      t.timestamps
    end
  end
end
