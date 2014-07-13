require "spec_helper"
require 'capybara/rspec'

feature "viewing the list of apps" do
  let!(:app) { FactoryGirl.create(:app, user: admin) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:member) { FactoryGirl.create(:user, :confirmed) }

  scenario "when user isn't logged in" do
    visit apps_path
    page.should have_content('Welcome to Blocmetrics! Please sign in.')
  end

  scenario "when user doesn't own an app" do
    sign_in_as!(admin)
    page.should have_content(app.name)
    click_link 'Sign out'
    sign_in_as!(member)
    visit apps_path
  end

  scenario "when user owns an app" do
    sign_in_as!(admin)
    visit apps_path
    page.should have_content(app.name)
  end
end