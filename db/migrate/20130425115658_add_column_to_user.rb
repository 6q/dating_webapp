class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :physical_style, :string 
    add_column :users, :physical_desc, :string
    add_column :users, :height, :integer
    add_column :users, :weight, :integer   
    add_column :users, :complexion, :string    
    add_column :users, :child, :string  
    add_column :users, :child_want, :string   
    add_column :users, :smoke, :string 
    add_column :users, :smoke_tolerance, :string 
    add_column :users, :diet, :string    
    add_column :users, :alcohol, :string    
    add_column :users, :drugs, :string  
    add_column :users, :drug_frequency, :string   
    add_column :users, :religion, :string  
    add_column :users, :religion_opinion, :string 
    add_column :users, :animal_like, :string 
    add_column :users, :animal_have, :string 
    add_column :users, :study_level, :string 
    add_column :users, :language, :string    
    add_column :users, :job, :string    
    add_column :users, :salary, :string 
    add_column :users, :description, :string
  end
end
