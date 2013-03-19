class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :surname, :string
    add_column :users, :screen_name, :string
    add_column :users, :gender, :integer
    add_column :users, :orientation, :string
    add_column :users, :marital_status, :string
    add_column :users, :birth_date, :date
    add_column :users, :zip_code, :string
    add_column :users, :town, :integer
    add_column :users, :country, :string
    add_column :users, :newsletter_optin, :boolean
  end
end
