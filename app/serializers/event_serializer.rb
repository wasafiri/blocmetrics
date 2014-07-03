class EventSerializer < ActiveModel::Serializer

  attributes :id, :ip_address, :web_property_id, :action, :created_at, :updated_at
  
end