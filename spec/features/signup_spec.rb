require 'rails_helper'

RSpec.describe 'the signup process', type: :feature do

  it 'signs @user up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'user1@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(current_path).to eq(contacts_path)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end