require "spec_helper"

describe HotelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/hotels" }.should route_to(:controller => "hotels", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/hotels/new" }.should route_to(:controller => "hotels", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/hotels/1" }.should route_to(:controller => "hotels", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/hotels/1/edit" }.should route_to(:controller => "hotels", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/hotels" }.should route_to(:controller => "hotels", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/hotels/1" }.should route_to(:controller => "hotels", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/hotels/1" }.should route_to(:controller => "hotels", :action => "destroy", :id => "1")
    end

  end
end
