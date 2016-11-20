require 'rails_helper'

RSpec.describe Ride do

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :company }
  end

   describe 'validations' do
    it {is_expected.to validate_presence_of :start_address }
    it {is_expected.to validate_presence_of :destination_address }
    it {is_expected.to validate_presence_of :payment_amount }
  end
end