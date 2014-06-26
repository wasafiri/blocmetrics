require "spec_helper"
require 'capybara/rspec'

feature 'Project manager creates TODO' do
  scenario 'Successfully' do
      visit '/apps/new'
      fill_in 'app_name', with: 'My personal website'
      fill_in 'app_desc', with: 'Contains my blog and other stuff'
    	click_button 'Save'
    	expect( page ).to have_content('App was added successfully.')
      expect( page ).to have_content('My personal website')
      expect( page ).to have_content('Contains my blog and other stuff')
  	end

  scenario 'With description missing' do
      visit '/apps/new'
      visit new_app_path
      fill_in 'app_name', with: ''
    	click_button 'Save'
    	expect( page ).to have_content('can\'t be blank')
  end
end
