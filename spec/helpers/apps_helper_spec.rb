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




# Specs in this file have access to a helper object that includes
# the AppsHelper. For example:
#
# describe AppsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
#describe AppsHelper do
#  pending "add some examples to (or delete) #{__FILE__}"
#end
