class RoomsController < ApplicationController
  before_filter :find_hotel
  before_filter :authorize_hotel, :except=>[:index, :show]
  before_filter :check_new, :only=>:index
  before_filter :find_dynamic_fields, :only=>[:new, :edit, :create, :update]
  before_filter :find_room, :only=>[:edit, :update]
  
  def index
    if @hotel
      @rooms = @hotel.rooms
    else
      @rooms = Room.joins("LEFT JOIN hotels ON hotels.id = rooms.hotel_id")
    end
  end

  def new
    @room = Room.new
    @room.build_prices_months
  end
  
  def create
    @room = Room.new(params[:room])
    if @room.valid? and @hotel.rooms << @room
      @room.save_dynamic_fields(params[:fields])
      @room.save_photos(params[:images])
      redirect_to new_hotel_room_path(@hotel), :notice=>t("rooms.successfully_create")
    else
      ( 12 - @room.prices.size ).times do 
        @room.prices.build
      end
      render :action=>"new"
    end
  end

  def edit
    #render edit
  end

  def update
    if @room.update_attributes(params[:room])
      @room.save_dynamic_fields(params[:fields])
      @room.save_photos(params[:images])
      redirect_to hotel_room_path(@hotel, @room), :notice=>t("rooms.successfully_update")
    else
      render :action=>:edit
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @images = @room.images
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

  def find_dynamic_fields
    @dynamic_fields = DynamicModel.return_dynamic_fields("Room")
  end

  def find_room
    @room = Room.find(params[:id])
  end
end

