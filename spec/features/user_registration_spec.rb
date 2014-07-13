require 'spec_helper'
require 'capybara/rspec'

feature 'Creating A New User' do

	let(:user) { FactoryGirl.build(:user) }

  scenario 'successfully' do
  	# binding.pry
  	visit new_user_registration_path
    # save_and_open_page
    fill_in 'Email',             			:with => user.email
    fill_in "Password",              	:with => "password"
    fill_in "Password confirmation", 	:with => "password"
    click_button "Sign up"
    expect( page ).to have_content('A message with a confirmation link has been sent to your email address.')
    email = open_email(user.email)
		click_first_link_in_email
    page.should have_content("Your account was successfully confirmed")
  end
end
