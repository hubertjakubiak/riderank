class CreateRides < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.string :start_address
      t.string :destination_address
      t.integer :distance
      t.decimal :payment_amount
    end
  end
end
