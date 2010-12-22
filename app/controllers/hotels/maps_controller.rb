include Geokit::Geocoders

class Hotels::MapsController < ApplicationController
  before_filter :find_hotel
  before_filter :authorize_hotel, :exept=>[:index]

  def new
    p @hotel.geo_place
    @gg_locate = GoogleGeocoder.geocode(@hotel.geo_place)
    @hotel_map = GMap.new("map")
    @hotel_map.control_init(:large_map => true, :map_type => true)
    @map = Map.new

    if @hotel.coordinate
      coordinates = [@hotel.coordinate.lat, @hotel.coordinate.lng]
      @hotel_map.center_zoom_init(coordinates, @hotel.coordinate.zoom)
      @hotel_map.overlay_init(GMarker.new(coordinates, :title => geo_hotel, :info_window => geo_place))
    elsif @gg_locate.success
      coordinates = [@gg_locate.lat, @gg_locate.lng]
      @hotel_map.center_zoom_init(coordinates, 7)
      @hotel_map.overlay_init(GMarker.new(coordinates, :title => geo_hotel, :info_window => geo_place))
    else
      @hotel_map.center_zoom_init([44.465151,40.935547], 6)
    end
  end

  def index
  end

private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def authorize_hotel
    authorize! :update, @hotel
  end
end
