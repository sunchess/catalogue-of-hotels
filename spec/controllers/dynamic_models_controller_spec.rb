require 'spec_helper'

describe DynamicModelsController do
  render_views
  login_admin

  def valid_params
    {"title"=>"Place"}
  end

  def update_valid_params
    {"title"=>"User"}
  end

  def not_valid_params
    {"title"=>"Pl"}
  end

  def mock_dynamic_model(stubs={})
    @mock_place ||= mock_model(DynamicModel, stubs.update(:title=>"Place"))
  end

  describe "GET index" do
    it "assigns all models as @models" do
      model = mock_dynamic_model
      DynamicModel.stub(:all) { [model] }
      get :index
      assigns(:dynamic_models).should eq([model])
    end
  end


  describe "GET new" do
    it "assigns a new model as @model" do
      DynamicModel.stub(:new) { mock_dynamic_model }
      get :new
      assigns[:dynamic_model].should be(mock_dynamic_model)
    end
  end

  describe "GET edit" do
    it "assigns the requested model as @model" do
      DynamicModel.stub(:find).with("37") { mock_dynamic_model }
      get :edit, :id => "37"
      assigns(:dynamic_model).should be(mock_dynamic_model)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created model as @model" do
        DynamicModel.stub(:new).with(valid_params) { mock_dynamic_model(:save => true) }
        post :create, :dynamic_model => valid_params
        assigns(:dynamic_model).should be(mock_dynamic_model)
      end

      it "redirects to the created model" do
        DynamicModel.stub(:new) { mock_dynamic_model(:save => true) }
        post :create, :dynamic_model => valid_params
        flash[:notice].should_not be_nil
        response.should redirect_to(dynamic_models_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved model as @model" do
        DynamicModel.stub(:new).with(not_valid_params) { mock_dynamic_model(:save => false) }
        post :create, :dynamic_model => not_valid_params
        flash[:notice].should be_nil
        assigns(:dynamic_model).should be(mock_dynamic_model)
      end

      it "re-renders the 'new' template" do
        DynamicModel.stub(:new) { mock_dynamic_model(:save => false) }
        post :create, :dynamic_model => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested  model" do
        DynamicModel.should_receive(:find).with("37").and_return(mock_dynamic_model)
        mock_dynamic_model.should_receive(:update_attributes).with(update_valid_params)
        put :update, :id => "37", :dynamic_model => update_valid_params
      end

      it "assigns the requested  model as @model" do
        DynamicModel.stub(:find) { mock_dynamic_model(:update_attributes => true) }
        put :update, :id => "1", :dynamic_model => update_valid_params
        assigns(:dynamic_model).should be(mock_dynamic_model)
      end

      it "redirects to the place" do
        DynamicModel.stub(:find) { mock_dynamic_model(:update_attributes => true) }
        put :update, :id => "1", :dynamic_model => valid_params
        flash[:notice].should_not be_nil
        response.should redirect_to(dynamic_models_path)
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        DynamicModel.stub(:find) { mock_dynamic_model(:update_attributes => false) }
        put :update, :id => "1", :dynamic_model => not_valid_params
        assigns(:dynamic_model).should be(mock_dynamic_model)
      end

      it "re-renders the 'edit' template" do
        DynamicModel.stub(:find) { mock_dynamic_model(:update_attributes => false) }
        put :update, :id => "1", :dynamic_model=> not_valid_params
        response.should render_template("edit")
      end
    end

  end


  describe "DELETE destroy" do
    it "destroys the requested model" do
      DynamicModel.should_receive(:find).with("37"){ mock_dynamic_model }
      mock_dynamic_model.should_receive(:destroy)
      DynamicModel.should_not be_exist(37)
      delete :destroy, :id => "37"
    end

    it "redirects to the models list" do
      DynamicModel.stub(:find) { mock_dynamic_model }
      delete :destroy, :id => "1"
      response.should redirect_to(dynamic_models_url)
    end
  end
end

