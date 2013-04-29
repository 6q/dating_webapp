class AddLookingForToUser < ActiveRecord::Migration
  def change
  	add_column :users, :lf_gender, :string
  	add_column :users, :lf_orientation, :string
  	add_column :users, :lf_marital_status, :string
  	add_column :users, :lf_age_between, :string
  	add_column :users, :lf_age_to, :string
  	add_column :users, :lf_city, :string
  	add_column :users, :lf_country, :string
  	add_column :users, :lf_postal_code, :string
    add_column :users, :lf_physical_style, :string
    add_column :users, :lf_physical_desc, :string
    add_column :users, :lf_height_between, :integer
    add_column :users, :lf_height_to, :integer
    add_column :users, :lf_weight_between, :integer
    add_column :users, :lf_weight_to, :integer
    add_column :users, :lf_complexion, :string
    add_column :users, :lf_child, :string
    add_column :users, :lf_child_want, :string
    add_column :users, :lf_smoke, :string
    add_column :users, :lf_smoke_tolerance, :string
    add_column :users, :lf_diet, :string
    add_column :users, :lf_alcohol, :string
    add_column :users, :lf_drugs, :string
    add_column :users, :lf_drug_frequency, :string
    add_column :users, :lf_religion, :string
    add_column :users, :lf_religion_opinion, :string
    add_column :users, :lf_animal_like, :string
    add_column :users, :lf_animal_have, :string
    add_column :users, :lf_study_level, :string
    add_column :users, :lf_language, :string
    add_column :users, :lf_job, :string
    add_column :users, :lf_salary, :string
    add_column :users, :lf_description, :string
  end
end
