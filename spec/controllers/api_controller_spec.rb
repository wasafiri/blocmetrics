require 'spec_helper'

describe EventsController, :type => :api do

	before do
    Timecop.freeze(Time.now)
  end

  after do
    Timecop.return
  end

  let(:event) { FactoryGirl.create :event }
  let(:params) {
    {
      :event => {
        :ip_address => event.ip_address,
        :web_property_id => event.web_property_id,
        :action => event.action
      }
    }
  }

  it 'receives an event from a website' do

    post :create, params

    expect(response).to be_success
    json = JSON.parse(response.body)["event"]
    json["ip_address"].should eql(event.ip_address)
    json["web_property_id"].should eql(event.web_property_id)
    json["action"].should eql(event.action)
    (json['updated_at']).to_date.should eql(Time.now.to_date)

  end
end