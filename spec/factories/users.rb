# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	sequence(:email) { |n| "thedude#{n}@abides.com" }
  	password "password"
  	password_confirmation "password"

    trait :confirmed do
      after(:create) do |user|
        user.confirm!
      end
    end

    trait :admin do
      confirmed
      after(:create) do |user|
        user.update_attribute(:role, 'admin')
      end
    end
  end
end