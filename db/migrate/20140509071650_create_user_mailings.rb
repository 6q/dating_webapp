class CreateUserMailings < ActiveRecord::Migration
  def change
    create_table :user_mailings do |t|
      t.references :user
      t.integer :sent_user_id

      t.timestamps
    end
    add_index :user_mailings, :user_id
  end
end
