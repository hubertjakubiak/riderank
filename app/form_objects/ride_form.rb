class RideForm
  include ActiveModel::Model
  attr_accessor :date, :start_address, :destination_address, :payment_amount, :company_id, :current_user

  validates :date, :company_id, :start_address, :destination_address, :payment_amount, presence: true

  validate :distance_checker_response

  def save
    return false unless valid?
    Ride.create(ride_params)
    true
  end

  private

  def ride_params
    {
      date: date,
      start_address: start_address, 
      destination_address: destination_address,
      payment_amount: payment_amount,
      company_id: company_id,
      user: current_user,
      distance: calculate_distance,
    }
  end

  def calculate_distance
    distance_response['routes'][0]['legs'][0]['distance']['value']
  end

  def distance_response
    @distance_response ||= DistanceResponse.response(start_address, destination_address) 
  end

  def distance_checker_response
    unless distance_response.present?
      errors.add(:base, 'Invalid distance')
    end
  end
end