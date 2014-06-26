require 'spec_helper'

describe AppsController do

	before do
    	@app = App.new(name: "Example App", desc: "Does stuff")
  	end

	subject { @app }

	it { should respond_to(:name) }
    it { should respond_to(:desc) }
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