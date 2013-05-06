class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.integer :user_id
      t.integer :creator_id
      t.integer :romantic, :default => 3, :null => false
      t.integer :adventurer, :default => 3, :null => false
      t.integer :friendly, :default => 3, :null => false
      t.integer :familiar, :default => 3, :null => false
      t.integer :hardWorking, :default => 3, :null => false
      t.integer :extroverted, :default => 3, :null => false
      t.integer :generous, :default => 3, :null => false
      t.integer :reserved, :default => 3, :null => false
      t.integer :sociable, :default => 3, :null => false
      t.integer :quiet, :default => 3, :null => false
      t.integer :demanding, :default => 3, :null => false
      t.integer :prideful, :default => 3, :null => false
      t.integer :solitary, :default => 3, :null => false
      t.integer :tenacious, :default => 3, :null => false
      t.integer :attentive, :default => 3, :null => false
      t.integer :goodHumored, :default => 3, :null => false
      t.integer :spontaneous, :default => 3, :null => false
      t.integer :restless, :default => 3, :null => false
      t.integer :sensitive, :default => 3, :null => false
      t.integer :shy, :default => 3, :null => false
      t.integer :possessive, :default => 3, :null => false
      t.integer :jealous, :default => 3, :null => false
      t.integer :faithful, :default => 3, :null => false
      t.timestamps
    end
  end
end
