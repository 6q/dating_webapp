class CreateEmailSettings < ActiveRecord::Migration
  def change
    create_table :email_settings do |t|
      t.integer :user_id
      t.boolean :no_email_online
      t.boolean :profile_visit
      t.boolean :receive_message
      t.boolean :like
      t.boolean :star_rating
      t.boolean :celestino_recommendation
      t.boolean :newsletter
      t.boolean :user_suggestions
      t.boolean :new_users_nearby

      t.timestamps
    end
  end
end
