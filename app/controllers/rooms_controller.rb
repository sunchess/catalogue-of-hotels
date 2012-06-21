class RoomsController < ApplicationController
  protect_from_forgery :except => :delete_image
  before_filter :find_hotel
  add_breadcrumb Proc.new{|c| c.t("rooms.navigation")}, :hotel_room_path, :only=>"show"
  add_breadcrumb Proc.new{|c| c.t("rooms.new.title")}, :new_hotel_room_path, :only=>%w{new create}
  add_breadcrumb Proc.new{|c| c.t("rooms.edit.title")}, :edit_hotel_room_path, :only=>%w{edit update}

  before_filter :authorize_hotel, :except=>[:index, :show]
  before_filter :check_new, :only=>:index
  before_filter :find_dynamic_fields, :only=>[:new, :edit, :create, :update]
  before_filter :find_room, :only=>[:edit, :update, :delete_image, :destroy]
  before_filter :set_images_fields, :only => %w{edit update}
  before_filter :init_search

  def index
    if @hotel
      @rooms = @hotel.rooms.paginate(:page=>params[:page])
      add_breadcrumb I18n.t("rooms.navigation"), :hotel_rooms_path
    else
      @search = Search.new(params[:search])
      @rooms = Room.joins(:hotel).where("hotels.draft"=>false).paginate(:page=>params[:page], :per_page=>15)
      add_breadcrumb I18n.t("rooms.navigation"), :rooms_path
    end
  end

  def new
    @room = Room.new
    @room.build_prices_months
    set_images_fields
  end

  def create
    @room = Room.new
    @room.accessible = [:ad] if admin?
    @room.attributes = params[:room]
    if @room.valid? and @hotel.rooms << @room
      @room.save_dynamic_fields(params[:fields])
      @room.save_photos(params[:images])
      redirect_to new_hotel_room_path(@hotel), :notice=>t("rooms.successfully_create")
    else
      ( 12 - @room.prices.size ).times do
        @room.prices.build
      end
      set_images_fields
      render :action=>"new"
    end
  end

  def edit
    #render edit
  end

  def update
    @room.accessible = [:ad] if admin?
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

  def delete_image
    @image = @room.images.find(params[:image])
    if @image
      @image.destroy
      respond_to do |format|
        format.html {redirect_to edit_hotel_room_path(@hotel, @room)}
        format.js
      end
    else
      render :nothing=>true
    end
  end

  def destroy
    @room.destroy
    redirect_to hotel_rooms_path(@hotel), :notice=>t("rooms.successfully_destroy")
  end

  private
  def init_search
    params[:search] = {} unless params[:search]
  end

  def find_hotel
    if params[:hotel_id]
      @hotel = Hotel.find(params[:hotel_id])
      add_breadcrumb I18n.t("hotels.navigation"), hotels_path
      add_breadcrumb @hotel.name, hotel_path(@hotel)
    end
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

  def set_images_fields
    @images_fields = if @room.images.count < 5
                       5
                     elsif @room.images.count >= 5 and  @room.images.count < 10
                       5
                     else
                       15 - @room.images.count
                     end
  end
end

