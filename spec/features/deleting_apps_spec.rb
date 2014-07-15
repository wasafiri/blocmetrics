require "spec_helper"
require 'capybara/rspec'

feature 'deleting an App' do
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:member) { FactoryGirl.create(:user, :confirmed) }
  let!(:app) { FactoryGirl.create(:app, user: admin) }
  let(:user_app) { FactoryGirl.create(:app, user: member) }

  scenario 'as regular user who does not own the app' do
    sign_in_as!(member)
    visit apps_path
    expect( page ).not_to have_content("Destroy")
  end

  scenario 'as regular user who owns the app' do
    user_app
    sign_in_as!(member)
    visit apps_path
    expect( page ).to have_content(user_app.name)
    expect{
      click_link("Destroy")
      }.to change(App,:count).by(-1)
    expect( page ).to have_content("The app #{user_app.name} was successfully deleted.")
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