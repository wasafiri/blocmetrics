# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    ip_address "200.201.202.203"
    web_property_id "PretendThisIsMyWebPropertyID"
    action "PretendThisIsMyAction"
    created_at ""
    updated_at "2014-06-24 21:49:07"
  end
end
