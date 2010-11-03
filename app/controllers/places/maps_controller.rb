class Places::MapsController < ApplicationController


  load_and_authorize_resource
  before_filter :find_place

  def create

    if @place.coordinate
      @place.coordinate.destroy
    end
    @map = Map.new(params[:map])
    @place.coordinate = @map
  end

  private
  def find_place
    @place = Place.find(params[:place_id])
  end

end
