require 'rails_helper'

feature 'Creating ride', js: true do
  before do
    FactoryGirl.create(:company, name: 'Sawa')
    FactoryGirl.create(:company, name: 'Uber')
    FactoryGirl.create(:company, name: 'MPT')
    sign_in
  end

  it 'create ride' do
    visit root_path
    click_link 'Add New Ride'
    fill_in 'Date', with: Date.today
    fill_in 'Start address', with: 'Parkingowa 18, Żyrardów, Polska'
    fill_in 'Destination address', with: 'Słomińskiego 7, Warszawa, Polska'
    fill_in 'Payment amount', with: 100
    find('#company-select').find(:css, "option[value='1']").click
    click_on "Create Ride"

    expect(page).to have_content('57.7 km')
    logout
  end
end