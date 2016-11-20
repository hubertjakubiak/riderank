require 'rails_helper'

RSpec.describe Company do

  describe 'associations' do
    it { is_expected.to have_many :rides }
  end
  
end