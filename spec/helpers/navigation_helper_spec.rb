require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the NavigationHelper. For example:
#
# describe NavigationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe NavigationHelper do
  describe "test set_current_style method" do

    before do
      params = {:controller=>"places"}
      helper.stub!(:params).and_return(params)
    end

    it "should return current" do
      helper.set_current_style("places").should == "current"
    end

    it "should return nil" do
      helper.set_current_style("foo").should == nil
    end
  end



end
