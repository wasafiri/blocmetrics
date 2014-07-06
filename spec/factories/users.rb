# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	email "thedude@abides.com"
  	password "shutupdonny"
  	password_confirmation "shutupdonny"

  	factory :confirmed_user do
  		after(:create) do |user|
  			user.confirm!
  		end
  	end

  	factory :admin_user do
  		after(:create) do |user|
  			user.confirm!
  			user.update_attribute(:admin, true)
  		end
  	end
  end
end
