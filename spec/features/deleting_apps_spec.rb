require "spec_helper"
require 'capybara/rspec'

feature 'deleting an App' do
  let!(:app) { FactoryGirl.create(:app, user: admin) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:member) { FactoryGirl.create(:user, :confirmed) }

  scenario 'as regular user who does not own the app' do
    sign_in_as!(member)
    visit apps_path
    expect( page ).not_to have_content("Destroy")
  end

  scenario 'as regular user who owns the app' do
    sign_in_as!(member)
    visit new_app_path
    fill_in 'app_name', with: 'Regular user app delete test'
    fill_in 'app_desc', with: 'This is a test of a regular user who owns the app'
    expect{
      click_link_or_button("Save")
      }.to change(App,:count).by(+1)
    click_link_or_button("Sign out")
    sign_in_as!(member)
    expect( page ).to have_content("Regular user app delete test")
  end

  scenario 'as admin' do
    sign_in_as!(admin)
    visit apps_path
    expect{
      click_link("Destroy")
      }.to change(App,:count).by(-1) 
    expect( page ).to have_content("The app #{app.name} was successfully deleted.")
  end
end