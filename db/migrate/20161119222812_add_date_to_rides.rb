class AddDateToRides < ActiveRecord::Migration[5.0]
  def change
    add_column :rides, :date, :date
  end
end
