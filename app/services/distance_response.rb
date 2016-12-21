class DistanceResponse 
  def initialize(start_address, destination_address)
    @url = 'http://maps.googleapis.com/maps/api/directions/json?origin="'+ start_address + '"&destination="' + destination_address + '"&sensor=false'
  end

  def self.response(start_address, destination_address)
    new(start_address, destination_address).response
  rescue => error
    nil
  end

  def response
    JSON.parse(HTTParty.get(uri).body)
  end

  def uri
    Addressable::URI.parse(URI.encode(@url))
  end
end