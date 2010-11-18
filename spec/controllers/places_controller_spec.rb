require 'spec_helper'
require 'controllers_helper'

describe PlacesController do
  #render_views
  login_admin

  def main_model
    Place
  end

  def valid_params
    {"title"=>"Сочи", "draft"=>"1"}
  end

  def update_valid_params
    {"title"=>"Туапсе", "draft"=>"0"}
  end

  def not_valid_params
    {"title"=>"", "draft"=>"0"}
  end


  def mock_store(stubs={})
    @mock_store ||= mock_model(main_model, stubs.update(:title=>"Краснодарский край", :draft=>false, :parent=>nil, :parent_id=>nil, :images_count=>1 ))
  end

  before do
    @model = mock_model(DynamicModel, :title=>"Place")
    DynamicModel.stub(:find_by_title){@model}
    @model.stub(:id){1}
    @field = mock_model(DynamicField, :title=>"Трансфер до места", :draft=>false, :permalink=>"transfer_do_mesta")
    @model.stub(:dynamic_fields){[@field]}
    @map = mock_model(Map, :lat=>34.345675, :lng=>32.4355654, :zoom=>4)
    @image = mock_model(Image, :image=>"DSCN3194.JPG", "draft?"=>false)
    
    @image.image.stub(:url){"/system/1/large/DSCN3194.JPG"}
    @images = [@image]
    @images.stub(:limited){@images}
  end

  describe "GET index" do
    it "assigns all places as @places" do
      place = mock_store
      place.stub(:draft?){false}
      place.stub(:children){[mock_store]}
      Place.should_receive(:where).with(:parent_id=>nil).and_return(place)
      place.should_receive(:includes).with([:children]).and_return(place)
      place.should_receive(:order).with(:position).and_return([place])

      get :index
      response.should be_success
      assigns(:places).should eq([place])
    end
  end

  describe "GET show" do
    it "assigns the requested place as @place" do
      mock_store.stub(:coordinate){@map}
      mock_store.stub(:dynamic_fields){[@field]}
      mock_store.stub(:images){@images}
      Image.stub(:new){@image}
      get_show(main_model, mock_store, :place)
    end
  end

  describe "GET new" do
    it "assigns a new place as @place" do
      mock_store.stub(:dynamic_fields){[@field]}
      get_new(main_model, mock_store, :place)
    end
  end

  describe "GET edit" do
    it "assigns the requested place as @place" do
      mock_store.stub(:dynamic_fields){[@field]}
      get_edit(main_model, mock_store, :place)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created place as @place" do
        main_model.stub(:new).with(valid_params){mock_store}
        mock_store.stub(:draft=){true}
        mock_store.stub(:save){true}
        post :create, :place => valid_params
        assigns(:place).should be(mock_store)
      end

      it "redirects to the created place" do
        main_model.stub(:new){ mock_store}
        mock_store.stub(:draft=){true}
        mock_store.stub(:save){true}
        mock_store.stub(:dynamic_fields){[@field]}
        post :create, :place => valid_params
        response.should redirect_to(places_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved place as @place" do
        Place.stub(:new).with(not_valid_params){ mock_store }
        mock_store.stub(:draft=){true}
        mock_store.stub(:save){false}
        mock_store.stub(:dynamic_fields){[@field]}
        post :create, :place => not_valid_params
        assigns(:place).should be(mock_store)
      end

      it "re-renders the 'new' template" do
        main_model.stub(:new) { mock_store }
        mock_store.stub(:draft=){true}
        mock_store.stub(:save){false}
        mock_store.stub(:dynamic_fields){[@field]}
        post :create, :place => not_valid_params
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested place" do
        main_model.should_receive(:find).with("37") { mock_store }
        mock_store.should_receive(:update_attributes).with(update_valid_params)
        mock_store.stub(:dynamic_fields){[@field]}
        put :update, :id => "37", :place => update_valid_params
      end

      it "assigns the requested place as @place" do
        main_model.stub(:find) { mock_store }
        mock_store.stub(:update_attributes){true}
        put :update, :id => "1"
        assigns(:place).should be(mock_store)
      end

      it "redirects to the place" do
        main_model.stub(:find) { mock_store }
        mock_store.stub(:update_attributes){true}
        put :update, :id => "1"
        response.should redirect_to(place_url(mock_store))
      end
    end

    describe "with invalid params" do
      it "assigns the place as @place" do
        main_model.stub(:find) { mock_store }
        mock_store.stub(:update_attributes){false}
        mock_store.stub(:dynamic_fields){[@field]}
        put :update, :id => "1"
        assigns(:place).should be(mock_store)
      end

      it "re-renders the 'edit' template" do
        main_model.stub(:find) { mock_store }
        mock_store.stub(:update_attributes){false}
        mock_store.stub(:dynamic_fields){[@field]}
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested place" do
      main_model.should_receive(:find).with("37") { mock_store }
      mock_store.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the places list" do
      main_model.stub(:find) { mock_store }
      delete :destroy, :id => "1"
      response.should redirect_to(places_url)
    end
  end

end
