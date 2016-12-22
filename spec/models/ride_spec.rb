require 'rails_helper'

RSpec.describe Ride do

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :company }
  end
end