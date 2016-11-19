class Ride < ActiveRecord::Base
  belongs_to :user

  validates :start_address, presence: true
  validates :destination_address, presence: true
  validates :payment_amount, presence: true

  before_create :calculate_distance

  def calculate_distance
    url = 'http://maps.googleapis.com/maps/api/directions/json?origin="'+ start_address + '"&destination="' + destination_address + '"&sensor=false'
    encoded_url = URI.encode(url)
    uri = Addressable::URI.parse(encoded_url)
    response = HTTParty.get(uri)
    json = JSON.parse(response.body)
    distance = json['routes'][0]['legs'][0]['distance']['text']
    self.distance = distance
  end
end
