include Geokit::Geocoders

class PlacesController < ApplicationController
  before_filter :find_place, :only=>[:edit, :update, :destroy, :show]
  authorize_resource
  add_breadcrumb Proc.new{|c| c.t("places.navigation")}, :places_path#, :only=>%w{show new edit create update}
  add_breadcrumb Proc.new{|c| c.t("places.new.title")}, :new_place_path, :only=>%w{new create}
  add_breadcrumb Proc.new{|c| c.t("places.edit.title")}, :edit_place_path, :only=>%w{edit update}

  #caches_action :index, :show, :layout=>false :unless=>proc do |c|
   # c.can?(:manage, Place)
  #end
  
  #after_filter :delete_cache, :only=>[:update, :create, :destroy]
  before_filter :find_parents_and_fields, :only=>[:new, :edit, :create, :update]

  def index
    if can?(:manage, Place)
      @places = Place.where(:parent_id=>nil).includes([:children]).order(:position)
    else
      @places = Place.where(:parent_id=>nil, :draft=>false).includes([:children]).order(:position)
    end
  end

  def show
    if @place.parent
      geo_place = "#{@place.title}, #{@place.parent.title}"
      add_breadcrumb @place.parent.title, place_path(@place.parent)
      add_breadcrumb @place.title, place_path(@place)
    else
      geo_place = @place.title
      add_breadcrumb @place.title, place_path(@place)
    end

    @gg_locate = GoogleGeocoder.geocode(geo_place)
    @place_map = GMap.new("map")
    @place_map.control_init(:large_map => true, :map_type => true)
    @map = Map.new

    if @place.coordinate
      coordinates = [@place.coordinate.lat, @place.coordinate.lng]
      @place_map.center_zoom_init(coordinates, @place.coordinate.zoom)
      @place_map.overlay_init(GMarker.new(coordinates, :title => geo_place, :info_window => geo_place))
    elsif @gg_locate.success
      coordinates = [@gg_locate.lat, @gg_locate.lng]
      @place_map.center_zoom_init(coordinates, 7)
      @place_map.overlay_init(GMarker.new(coordinates, :title => geo_place, :info_window => geo_place))
    else
      @place_map.center_zoom_init([44.465151,40.935547], 6)
    end
    #for form
    @image = Image.new

    @images = if can? :manage, Image
                @place.images.limited
              else
                @place.images.not_draft.limited
              end
  end


  def new
    @place = Place.new
  end


  def edit
    #render edit
  end

  def create
    @place = Place.new
    @place.accessible = [ :draft, :paid_placement ] if admin?
    @place.attributes = params[:place]

    @place.draft = true

    if @place.save
      #TODO add it to model
      params[:fields].each do |field|
        @place.dynamic_fields << DynamicField.find_by_permalink(field)
      end if params[:fields]

      redirect_to places_path, :notice=>t('places.successfully_create')
    else
      render :action => "new"
    end
  end

  def update
    @place.accessible = [ :draft, :paid_placement ] if admin?
    if @place.update_attributes(params[:place])
      #TODO: add it to model
      if params[:fields]
        @place.dynamic_fields.clear
        params[:fields].each do |field|
          @place.dynamic_fields << DynamicField.find_by_permalink(field)
        end 
      else
        @place.dynamic_fields.clear
      end 
      redirect_to(@place, :notice => t('places.successfully_update'))
    else
      render :action => "edit"
    end
  end


  def destroy
    @place.destroy
    redirect_to(places_url, :notice => t('places.successfully_destroy'))
  end

private
  def find_parents_and_fields
    @parents = Place.where({:draft=>false, :parent_id=>nil}).order("parent_id, position").all
    @dynamic_fields = DynamicModel.return_dynamic_fields("Place")
  end

  def delete_cache
    expire_action :index
    expire_action :show
  end

  def find_place
    @place = Place.find(params[:id]) 
  end

end
