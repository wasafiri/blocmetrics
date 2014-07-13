require "spec_helper"
require 'capybara/rspec'

feature 'deleting an App' do
  let!(:app) { FactoryGirl.create(:app, user: admin) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:member) { FactoryGirl.create(:user, :confirmed) }

  scenario 'as regular user' do
    sign_in_as!(member)
    visit apps_path
    expect( page ).not_to have_content("Destroy")
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