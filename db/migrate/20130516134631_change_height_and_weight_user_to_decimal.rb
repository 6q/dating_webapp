class ChangeHeightAndWeightUserToDecimal < ActiveRecord::Migration
  def up
  	change_column :users, :height, :decimal
  	change_column :users, :weight, :decimal
  	change_column :users, :lf_height_between, :decimal
  	change_column :users, :lf_height_to, :decimal
  	change_column :users, :lf_weight_between, :decimal
  	change_column :users, :lf_weight_to, :decimal
  	remove_column :users, :lf_description
  end

  def down
  	change_column :users, :height, :integer
  	change_column :users, :weight, :integer
  	change_column :users, :lf_height_between, :integer
  	change_column :users, :lf_height_to, :integer
  	change_column :users, :lf_weight_between, :integer
  	change_column :users, :lf_weight_to, :integer
  	add_column :users, :lf_description, :string
  end
end

  
