require 'spec_helper'

describe AppsHelper do

  before do
    @app = App.new(name: "Example App", desc: "Does stuff", created_at: "2014-06-26 17:17:41 -0400")
  end

  subject { @app }

    it "should correctly format time" do
      pretty_up_time(@app).should == "June 26, 2014"
    end
end
