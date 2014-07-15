require 'spec_helper'

describe AppsController do
  @user = let(:user) { FactoryGirl.create(:user, :confirmed) }
	
  before do
    @app = App.new(id: "5000", name: "Example App", desc: "Does stuff", user_id: user.id)
    @app.save
    # Could also do @app = App.create(id: "5000", name: "Example App", desc: "Does stuff")
    controller.stub(:current_user){ user }
  end

  subject { @app }

    it { should respond_to(:name) }
    it { should respond_to(:desc) }
    it { should be_valid }

	it "responds to GET apps#index with an HTTP 200 successful status code" do
	  get :index
	    expect(response).to be_success
	    expect(response.status).to eq(200)
          end

	it "renders the index template" do
	  get :index
	  expect(response).to render_template("index")
	end

	it "responds to GET apps#show" do
	  get :show, id: @app
	  expect(response).to render_template("show")
	end

	context "valid attributes" do
	  it "successfully locates apps to edit" do
	    put :update, id: @app, app: {name: "Example App"}
	    assigns(:app).name.should eq(@app.name)
	  end

	  it "successfully changes the app attributes" do
	    put :update, id: @app.id, app: {name: "Renamed", desc: "Does other stuff good too", user_id: user.id}
            puts @app.inspect
	    @app.reload
	    @app.name.should eq("Renamed")
	    @app.desc.should eq("Does other stuff good too")
	  end
	end

	context "invalid attributes" do
	  it "successfully locates apps to edit" do
	    put :update, id: @app, app: {name: "Example App"}
	    assigns(:app).name.should eq(@app.name)
	  end

	  it "does not change the app attributes" do
	    put :update, id: @app, app: {name: nil, desc: "Does other stuff good too"}
	    @app.reload
	    @app.name.should eq("Example App")
	    @app.desc.should_not eq("Does other stuff good too")
	  end
	end
end
