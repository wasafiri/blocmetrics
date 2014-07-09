require "spec_helper"
require 'capybara/rspec'

feature 'Deleting an App' do
  scenario 'Successfully' do
# => Either the commented out lines below or the FactoryGirl lines will work.
#    visit new_app_path
#    fill_in 'app_name', with: 'My personal website'
#    fill_in 'app_desc', with: 'Contains my blog and other stuff'
#    click_button 'Save'
#    expect( page ).to have_content('App was added successfully.')
#    click_link_or_button 'Destroy'
#    expect( page ).to have_content('"My personal website" was successfully deleted.')
#  end
#end
    app = FactoryGirl.create(:app, name: 'My personal website', desc: 'Contains my blog and other stuff')
    visit apps_path
    expect{
      click_link("destroy_#{app.id}")
      }.to change(App,:count).by(-1)
    end
  end