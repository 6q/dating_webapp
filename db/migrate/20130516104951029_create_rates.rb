class CreateRates < ActiveRecord::Migration
  
  def self.up
      create_table :rates do |t|
        t.belongs_to :rater
        t.belongs_to :rateable
        t.float :stars, :null => false
        t.timestamps
      end

      add_index :rates, :rater_id
      add_index :rates, :rateable_id
    end

    def self.down
      drop_table :rates
    end  
    
end