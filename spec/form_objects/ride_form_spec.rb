require 'rails_helper'

RSpec.describe RideForm, type: :model  do
  let(:date) { '2016-12-28' }
  let(:start_address) { 'Żyrardów'}
  let(:destination_address) { 'Warszawa'}
  let(:payment_amount) { '56' }
  let(:company_id) { create(:company).id }
  let(:user) { create(:user) }
  let(:ride_params) do
    {
      date: date,
      start_address: start_address, 
      destination_address: destination_address,
      payment_amount: payment_amount,
      company_id: company_id,
      current_user: user,
    }
  end
  let(:valid_response) do
    {
      'routes' => [
        {
          'legs' => [
            {
              'distance' => {
                'value' => 52399
              }
            }
          ]
        }
      ]
    }
  end
  let(:invalid_response) { nil }
  let(:call) { subject.save}
  before do 
    allow(DistanceResponse)
      .to receive(:response)
      .and_return(distance_response)
    #allow(DistanceResponse).to receive(:response) {distance_response}
  end
  subject { described_class.new(ride_params)}
  shared_examples_for 'check_value_for' do |method_name, result|
    it "has correct #{method_name}" do
        expect(object.send(method_name)).to eq(result)
      end
  end
  # shared_examples_for 'check_value_for' do |method_name, result|
  #   it "has correct #{method_name}" do
  #       expect(object.send(method_name)).to eq(result)
  #     end
  # end
  context 'valid params' do
    let(:distance_response) { valid_response }
    it 'returns true' do
      expect(call).to be_truthy
    end
    it 'creates new ride' do
      expect { call }.to change { Ride.count}.by(1)
    end
    context 'after call' do
      before { call }
      let(:object) { Ride.last }
      it_behaves_like 'check_value_for', :date, Date.parse('2016-12-28')
      it_behaves_like 'check_value_for', :start_address, 'Żyrardów'
      it_behaves_like 'check_value_for', :destination_address, 'Warszawa'
    end
  end
  context 'invalid params' do
    let(:distance_response) { invalid_response }
    it 'returns false' do
      expect(call).to be_falsey
    end
  end
end