require 'spec_helper'

describe EventsController, :type => :api do
  it 'receives an event from a website' do
    # event = FactoryGirl.create(:event)

    params = {:event => {
    	:ip_address => "200.201.202.203", 
    	:web_property_id => "PretendThisIsMyWebPropertyID",
    	:action => "PretendThisIsMyAction",
    	:created_at => "",
    	:updated_at => "2014-06-24T21:49:07.000Z",
    }
	}
    	
    post :create, params

    # test for the 200 status-code
    expect(response).to be_success

    expect(JSON.parse(response.body).length).to eq(6)

    check_key_match("id")

    check_key_match("ip_address")
    check_value_match("200.201.202.203")

    check_key_match("web_property_id")
    check_value_match("PretendThisIsMyWebPropertyID")

    check_key_match("action")
    check_value_match("PretendThisIsMyAction")

    check_key_match("created_at")

    check_key_match("updated_at")
    check_value_match("2014-06-24T21:49:07.000Z")

  end

  private

  def check_key_match(key_inst)
  	expect(JSON.parse(response.body)).to have_key(key_inst)
  end

  def check_value_match(value_inst)
  	expect(JSON.parse(response.body)).to have_value(value_inst)
  end


end