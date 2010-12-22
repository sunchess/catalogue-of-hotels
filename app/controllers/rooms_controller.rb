class RoomsController < ApplicationController
  before_filter :find_hotel
  before_filter :authorize_hotel, :except=>[:index]
  before_filter :check_new, :only=>:index
  before_filter :find_dynamic_fields, :only=>[:new, :edit]
  
  def index
    if @hotel
      @rooms = @hotel.rooms
    else
      @rooms = Room.joins("LEFT JOIN hotels ON hotels.id = rooms.hotel_id")
    end
  end

  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params[:room])
    if @room.save
      @room.save_dynamic_fields(params[:fields])
      @room.save_photos(params[:images])
      redirect_to new_hotel_room_path(@hotel), :notice=>t("rooms.successfully_create")
    else
      render :action=>"new"
    end
  end

  def edit
  end

  private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id]) if params[:hotel_id]
  end

  def authorize_hotel
    authorize! :update, @hotel
  end

  def check_new
    if @hotel and can?(:update, @hotel) and  @hotel.rooms.count.zero?
      redirect_to new_hotel_room_path(@hotel)
    end
  end

  private
  def find_dynamic_fields
    @dynamic_fields = DynamicModel.return_dynamic_fields("Room")
  end
end

