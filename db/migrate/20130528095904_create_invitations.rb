class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invitor_id
      t.string :invited_email
      t.boolean :accepted, default: false
      t.string :invitation_code

      t.timestamps
    end
  end
end
