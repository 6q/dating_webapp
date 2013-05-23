class AddBodyAndDateToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :body, :text
    add_column :activities, :date, :date
  end
end
