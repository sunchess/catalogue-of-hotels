include Geokit::Geocoders

class Hotels::MapsController < ApplicationController
  add_breadcrumb Proc.new{|c| c.t("hotels.navigation")}, :hotels_path

  before_filter :find_hotel
  add_breadcrumb Proc.new{|c| c.t("hotels.add.map")}, :hotel_maps_path
  add_breadcrumb Proc.new{|c| c.t("hotels.maps.new.title")}, :new_hotel_map_path, :only=>%w{new create}

  before_filter :authorize_hotel, :except=>[:index]

  def new
    @place_map = YandexMap.new
    @map = Map.new
  end

  def create
    if @hotel.coordinate
      @hotel.coordinate.destroy
    end
    @map = Map.new(params[:map])
    @hotel.coordinate = @map
  end

  def index
    @place_map = YandexMap.new
  end

private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def authorize_hotel
    authorize! :update, @hotel
  end
end
