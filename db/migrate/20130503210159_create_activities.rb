class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :activity_type
      t.string :status
      t.integer :conversation_id

      t.timestamps
    end
  end
end
