require 'spec_helper'

describe EventsController do

	before do
    	@event = Event.new(ip_address: "192.168.9.1", web_property_id: "a5beq67wr",
    		action: "GET")
  	end

	subject { @event }

	it { should respond_to(:ip_address) }
    it { should respond_to(:web_property_id) }
    it { should respond_to(:action)}
    it { should respond_to(:created_at)}
    it { should respond_to(:updated_at)}
    it { should be_valid }

	it "responds successfully with an HTTP 200 status code" do
		get :index
			expect(response).to be_success
			expect(response.status).to eq(200)
	end

	it "renders the index template" do
		get :index
		expect(response).to render_template("index")
	end
end