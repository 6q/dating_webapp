class CreateUserHides < ActiveRecord::Migration
  def change
    create_table :user_hides do |t|
      t.integer :user_id
      t.integer :hidden_user_id

      t.timestamps
    end
  end
end
