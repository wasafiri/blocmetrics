require "spec_helper"
require 'capybara/rspec'

feature 'editing an app' do
  let!(:app) { FactoryGirl.create(:app, user: admin) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:member) { FactoryGirl.create(:user, :confirmed) }

  scenario 'as regular user who does not own the app' do
    sign_in_as!(member)
    visit apps_path
    expect( page ).not_to have_content('Edit')
  end

  scenario 'as regular user who owns the app' do
    sign_in_as!(member)
    visit new_app_path
    fill_in 'app_name', with: 'Regular user app delete test'
    fill_in 'app_desc', with: 'This is a test of a regular user who owns the app'
    expect{
      click_link_or_button("Save")
      }.to change(App,:count).by(+1)
    click_link("Edit")
    fill_in 'app[name]', with: 'Edited regular user app'
    click_button 'Save'
    expect( page ).to have_content('Edited regular user app')
  end

  scenario 'as admin' do
    sign_in_as!(admin)
    visit apps_path
    click_link "Edit"
    fill_in 'app[name]', with: 'Edited App Name'
    click_button 'Save'
    expect( page ).to have_content('Edited App Name')
  end

  scenario "as visitor" do
    visit root_path
    page.should_not have_link('Create New App')
  end

  scenario 'with missing description' do
    sign_in_as!(admin)
    visit apps_path
    click_link "Edit"
    fill_in 'app[name]', with: ''
  	click_button 'Save'
  	expect( page ).to have_content('can\'t be blank')
  end
end
