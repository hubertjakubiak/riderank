class AddCompanyIdToRides < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
    end
    add_reference :rides, :company, foreign_key: true
  end
end
