require 'spec_helper'

describe DynamicFieldsController do
  render_views
  login_admin

  def main_model
    DynamicField
  end

  def valid_params
    {"title"=>"On rooms", "draft"=>"1"}
  end

  def update_valid_params
    {"title"=>"On rooms 234", "draft"=>"0"}
  end

  def not_valid_params
    {"title"=>"", "draft"=>"0"}
  end


  def mock_store(stubs={})
    @mock_place ||= mock_model(main_model, stubs.update(:title=>"On rooms", :draft=>true))
  end

  before do
    @model = mock_model(DynamicModel, :title=>"Place")
    DynamicModel.stub(:find){@model}
    @model.stub(:id){1}
    @model.stub(:dynamic_fields){[]}
  end

  describe "GET index" do
    it "assigns all fields as @dynamic_fields" do
      #@field = Factory(:dynamic_field)

      controller.params = {:page => nil}
      field = mock_store
      field.stub(:draft?){false}
      main_model.should_receive(:where).with(:dynamic_model_id=>@model.id).and_return(field)
      field.should_receive(:order).with("position").and_return(field)
      field.should_receive(:paginate).with(:page=>controller.params[:page]).and_return([field])

      get :index, :dynamic_model_id=>1
      assigns(:dynamic_fields).should eq([field])
      response.should render_template("index")
    end
  end


  describe "GET new" do
    it "assigns a new field as @dynamic_field" do
      main_model.stub(:new) { mock_store }
      get :new, :dynamic_model_id=>1
      assigns[:dynamic_field].should be(mock_store)
      response.should render_template("new")
    end
  end

  describe "GET edit" do
    it "assigns the requested fields as @dynamic_fields" do
      main_model.stub(:find).with("37") { mock_store }
      get :edit, :id => "37", :dynamic_model_id=>1
      assigns(:dynamic_field).should be(mock_store)
      response.should render_template("edit")
    end
  end

  describe "GET edit_order" do
    it "assigns the requested change position" do
      field = mock_store
      field.stub(:draft?){false}
      main_model.should_receive(:where).with(:dynamic_model_id=>@model.id).and_return(field)
      field.should_receive(:order).with("position").and_return([field])

      get :edit_order, :dynamic_model_id=>1

      assigns(:dynamic_fields).should eq([field])
      response.should render_template("edit_order")
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created model as @model" do
        main_model.stub(:new).with(valid_params) { mock_store(:save => true) }
        post :create, :dynamic_field => valid_params,  :dynamic_model_id=>1
        assigns(:dynamic_field).should be(mock_store)
      end

      it "redirects to the created model" do
        main_model.stub(:new) { mock_store(:save => true) }
        post :create, :dynamic_field => valid_params,  :dynamic_model_id=>1
        flash[:notice].should_not be_nil
        response.should redirect_to(dynamic_model_dynamic_fields_path(@model.id))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved model as @model" do
        main_model.stub(:new).with(not_valid_params) { mock_store(:save => false) }
        post :create, :dynamic_field => not_valid_params,  :dynamic_model_id=>1
        flash[:notice].should be_nil
        assigns(:dynamic_field).should be(mock_store)
      end

      it "re-renders the 'new' template" do
        main_model.stub(:new) { mock_store(:save => false) }
        post :create, :dynamic_field => {},  :dynamic_model_id=>1
        response.should render_template("new")
      end
    end

  end


  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested" do
        main_model.should_receive(:find).with("37").and_return(mock_store)
        mock_store.should_receive(:update_attributes).with(update_valid_params)
        put :update, :id => "37", :dynamic_field => update_valid_params,  :dynamic_model_id=>1
      end

      it "assigns the requested" do
        main_model.stub(:find) { mock_store(:update_attributes => true) }
        put :update, :id => "1", :dynamic_field => update_valid_params,  :dynamic_model_id=>1
        assigns(:dynamic_field).should be(mock_store)
      end

      it "redirects to" do
        main_model.stub(:find) { mock_store(:update_attributes => true) }
        put :update, :id => "1", :dynamic_field => valid_params,  :dynamic_model_id=>1
        flash[:notice].should_not be_nil
        response.should redirect_to(dynamic_model_dynamic_fields_path(@model.id))
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        main_model.stub(:find) { mock_store(:update_attributes => false) }
        put :update, :id => "1", :dynamic_field => not_valid_params,  :dynamic_model_id=>1
        assigns(:dynamic_field).should be(mock_store)
      end

      it "re-renders the 'edit' template" do
        main_model.stub(:find) { mock_store(:update_attributes => false) }
        put :update, :id => "1", :dynamic_field=> not_valid_params ,  :dynamic_model_id=>1
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested model" do
      main_model.should_receive(:find).with("37"){ mock_store }
      mock_store.should_receive(:destroy)
      delete :destroy, :id => "37" ,  :dynamic_model_id=>1
    end

    it "redirects to" do
      main_model.stub(:find) { mock_store  }
      delete :destroy, :id => "1" ,  :dynamic_model_id=>1
      response.should redirect_to(dynamic_model_dynamic_fields_path(@model.id))
    end
  end

  describe "PUT update_order" do

    it "should update position" do
      field = mock_store
      main_model.should_receive(:where).with(:dynamic_model_id=>@model.id).and_return(field)
      field.should_receive(:order).with("position").and_return([field])

      put :update_order, :dynamic_model_id=>1, :field=>["1", "3", "2"]
      response.should be_success
    end

  end

end
