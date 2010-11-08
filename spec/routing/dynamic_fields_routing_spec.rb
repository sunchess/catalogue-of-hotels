require "spec_helper"
describe DynamicFieldsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/dynamic_models/1/dynamic_fields" }.should route_to(:controller => "dynamic_fields", :dynamic_model_id=>"1", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/dynamic_models/1/dynamic_fields/new" }.should route_to(:controller => "dynamic_fields", :dynamic_model_id=>"1", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/dynamic_models/1/dynamic_fields/1/edit" }.should route_to(:controller => "dynamic_fields", :dynamic_model_id=>"1", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/dynamic_models/1/dynamic_fields" }.should route_to(:controller => "dynamic_fields", :dynamic_model_id=>"1", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/dynamic_models/1/dynamic_fields/1" }.should route_to(:controller => "dynamic_fields", :action => "update", :dynamic_model_id=>"1", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/dynamic_models/1/dynamic_fields/1" }.should route_to(:controller => "dynamic_fields", :action => "destroy", :dynamic_model_id=>"1", :id => "1")
    end

    it "recognizes and generates #edit_order" do
      { :get => "/dynamic_models/1/dynamic_fields/edit_order" }.should route_to(:controller => "dynamic_fields", :action => "edit_order", :dynamic_model_id=>"1")
    end

    it "recognizes and generates #update_order" do
      { :put => "/dynamic_models/1/dynamic_fields/update_order" }.should route_to(:controller => "dynamic_fields", :action => "update_order", :dynamic_model_id=>"1")
    end

  end
end