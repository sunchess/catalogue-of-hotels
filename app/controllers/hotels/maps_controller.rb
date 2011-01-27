include Geokit::Geocoders

class Hotels::MapsController < ApplicationController
  add_breadcrumb Proc.new{|c| c.t("hotels.navigation")}, :hotels_path

  before_filter :find_hotel
  add_breadcrumb Proc.new{|c| c.t("hotels.add.map")}, :hotel_maps_path
  add_breadcrumb Proc.new{|c| c.t("hotels.maps.new.title")}, :new_hotel_map_path, :only=>%w{new create}

  before_filter :authorize_hotel, :except=>[:index]

  def new
    @hotel_map = GMap.new("map")
    @hotel_map.control_init(:large_map => true, :map_type => true)
    @map = Map.new

    if @hotel.coordinate
      coordinates = [@hotel.coordinate.lat, @hotel.coordinate.lng]
      @hotel_map.center_zoom_init(coordinates, @hotel.coordinate.zoom)
      @hotel_map.overlay_init(GMarker.new(coordinates, :title => @hotel.name, :info_window => @hotel.name))
    else
      @hotel_map.center_zoom_init([44.465151,40.935547], 6)
    end
  end

  def create
    if @hotel.coordinate
      @hotel.coordinate.destroy
    end
    @map = Map.new(params[:map])
    @hotel.coordinate = @map
  end

  def index
    @hotel_map = GMap.new("map")
    @hotel_map.control_init(:large_map => true, :map_type => true)
    @map = Map.new

    if @hotel.coordinate
      coordinates = [@hotel.coordinate.lat, @hotel.coordinate.lng]
      @hotel_map.center_zoom_init(coordinates, @hotel.coordinate.zoom)
      @hotel_map.overlay_init(GMarker.new(coordinates, :title => @hotel.name, :info_window => @hotel.name))
    else
      @hotel_map.center_zoom_init([44.465151,40.935547], 6)
    end
  end

private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def authorize_hotel
    authorize! :update, @hotel
  end
end
