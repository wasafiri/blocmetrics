require 'spec_helper'
require 'capybara/rspec'

feature 'Creating A New User' do

	let(:user) { FactoryGirl.create(:user) }

  scenario 'Successfully' do
  	visit new_user_registration_path
    # save_and_open_page
    fill_in 'Email',             			:with => "user.email"
    fill_in "Password",              	:with => "user.password"
    fill_in "Password confirmation", 	:with => "user.password_confirmation"
    click_button "Sign up"
    expect( page ).to have_content('A message with a confirmation link has been sent to your email address.')
   	# sleep 2
  	# email = open_email(user.email)
		# email.should deliver_to(user.email)
		# click_link "Confirm My Account"
		# sleep 2

  end
end