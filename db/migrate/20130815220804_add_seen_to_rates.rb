class AddSeenToRates < ActiveRecord::Migration
  def change
    add_column :rates, :seen, :boolean, default: false
  end
end
