require 'rails_helper'

RSpec.describe RideForm, type: :model  do

  describe 'validations' do
    it {is_expected.to validate_presence_of :date }
    it {is_expected.to validate_presence_of :start_address }
    it {is_expected.to validate_presence_of :destination_address }
    it {is_expected.to validate_presence_of :payment_amount }
    it {is_expected.to validate_presence_of :company_id }
  end
end