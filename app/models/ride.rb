class Ride < ActiveRecord::Base
  belongs_to :user

  validates :start_address, presence: true
  validates :destination_address, presence: true
  validates :payment_amount, presence: true
end
