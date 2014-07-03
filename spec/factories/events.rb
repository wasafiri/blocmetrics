# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    ip_address "200.201.202.203"
    web_property_id "PretendThisIsMyWebPropertyID"
    action "PretendThisIsMyAction"
    #no need to handcode the timestamps, activerecord will create them
  end
end
