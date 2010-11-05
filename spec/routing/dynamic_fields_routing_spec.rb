require "spec_helper"
describe DynamicFieldsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/dynamic_model/1/dynamic_models" }.should route_to(:controller => "dynamic_models", :dynamic_model_id=>1, :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/dynamic_model/1/dynamic_models/new" }.should route_to(:controller => "dynamic_models", :dynamic_model_id=>1, :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/dynamic_model/1/dynamic_models/1/edit" }.should route_to(:controller => "dynamic_models", :dynamic_model_id=>1, :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/dynamic_model/1/dynamic_models" }.should route_to(:controller => "dynamic_models", :dynamic_model_id=>1, :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/dynamic_model/1/dynamic_models/1" }.should route_to(:controller => "dynamic_models", :action => "update", :dynamic_model_id=>1, :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/dynamic_model/1/dynamic_models/1" }.should route_to(:controller => "dynamic_models", :action => "destroy", :dynamic_model_id=>1, :id => "1")
    end

    it "recognizes and generates #edit_order" do
      { :delete => "/dynamic_model/1/dynamic_models/1/edit_order" }.should route_to(:controller => "dynamic_models", :action => "edit_order", :dynamic_model_id=>1, :id => "1")
    end

    it "recognizes and generates #update_order" do
      { :delete => "/dynamic_model/1/dynamic_models/1/update_order" }.should route_to(:controller => "dynamic_models", :action => "update_order",, :dynamic_model_id=>1 :id => "1")
    end

  end
end