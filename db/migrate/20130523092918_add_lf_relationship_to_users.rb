class AddLfRelationshipToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lf_relationship, :string
  end
end
