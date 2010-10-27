require "spec_helper"

describe PlacesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/places" }.should route_to(:controller => "places", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/places/new" }.should route_to(:controller => "places", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/places/1" }.should route_to(:controller => "places", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/places/1/edit" }.should route_to(:controller => "places", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/places" }.should route_to(:controller => "places", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/places/1" }.should route_to(:controller => "places", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/places/1" }.should route_to(:controller => "places", :action => "destroy", :id => "1")
    end

  end
end


describe DynamicModelsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/dynamic_models" }.should route_to(:controller => "dynamic_models", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/dynamic_models/new" }.should route_to(:controller => "dynamic_models", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/dynamic_models/1/edit" }.should route_to(:controller => "dynamic_models", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/dynamic_models" }.should route_to(:controller => "dynamic_models", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/dynamic_models/1" }.should route_to(:controller => "dynamic_models", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/dynamic_models/1" }.should route_to(:controller => "dynamic_models", :action => "destroy", :id => "1")
    end

  end
end
