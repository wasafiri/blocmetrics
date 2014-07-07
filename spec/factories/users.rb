# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "thedude#{n}@abides.com" }
  	password "password"
  	password_confirmation "password"
  end

  factory :confirmed_user, :parent => :user do
    after(:create) do |user|
      user.confirm!
    end
  end

  factory :admin_user, :parent => :confirmed_user do
    after(:create) do |user|
      user.update_attribute(:role, 'admin')
    end
  end
end