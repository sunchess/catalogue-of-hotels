include Geokit::Geocoders

class PlacesController < ApplicationController
   load_and_authorize_resource
   caches_action :index
   before_filter :delete_cache, :only=>[:update, :create, :destroy]
   before_filter :find_parents_and_fields, :only=>[:new, :edit, :create, :update]


  def index
    if can?(:manage, Place)
      @places = Place.where(:parent_id=>nil).includes([:children]).order(:position)
    else
      @places = Place.where(:parent_id=>nil, :draft=>false).includes([:children]).order(:position)
    end
  end

  def show
    geo_place =  if @place.parent
                  "#{@place.title}, #{@place.parent.title}"
                else
                  @place.title
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
      if params[:fields]
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
    @parents = Place.where({:draft=>false}).order("parent_id, position").all
    @dynamic_fields = DynamicModel.return_dynamic_fields("Place")
  end

  def delete_cache
    expire_action :index
  end


end
