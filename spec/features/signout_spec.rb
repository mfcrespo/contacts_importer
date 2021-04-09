require 'rails_helper'

RSpec.describe 'the signout process', type: :feature do
  before :each do
    User.create(email: 'user1@gmail.com', password: 'password')
  end
  it 'destroy session' do
    visit '/users/index'
    click_link 'Log Out'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed out successfully.')
  end
end