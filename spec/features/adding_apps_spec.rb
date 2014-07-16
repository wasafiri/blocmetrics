require "spec_helper"
require 'capybara/rspec'

feature 'creating an App' do
  let(:admin) { FactoryGirl.create(:user, :admin) }
  let(:member) { FactoryGirl.create(:user, :confirmed) }

  scenario 'as regular user' do
    sign_in_as!(member)
    visit new_app_path
    fill_in 'app_name', with: 'My personal website'
    fill_in 'app_desc', with: 'Contains my blog and other stuff'
    click_link_or_button 'Save'
    expect( page ).to have_content('App was added successfully.')
    expect( page ).to have_content('My personal website')
    expect( page ).to have_content('Contains my blog and other stuff')
  end

  scenario 'as admin' do
    sign_in_as!(admin)
    visit new_app_path
    fill_in 'app_name', with: 'My personal website'
    fill_in 'app_desc', with: 'Contains my blog and other stuff'
    click_link_or_button 'Save'
    expect( page ).to have_content('App was added successfully.')
    expect( page ).to have_content('My personal website')
    expect( page ).to have_content('Contains my blog and other stuff')
  end

  scenario 'as visitor' do
    visit root_path
    page.should_not have_content('Create New App')
  end

  scenario 'without app description' do
    sign_in_as!(admin)
    click_link 'Create New App'
    fill_in 'app[name]', with: ''
    click_link_or_button 'Save'
    expect( page ).to have_content('can\'t be blank')
  end
end
