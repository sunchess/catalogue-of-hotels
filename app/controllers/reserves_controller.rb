class ReservesController < ApplicationController
  before_filter :find_reserve, :only=>[:show, :edit, :update, :destroy]
  authorize_resource :reserf, :except=>%w{ publish change_status calculate }
  before_filter :find_hotel_and_room, :only=>%w{ new create edit update publish calculate }
  add_breadcrumb Proc.new{|c| c.t("reserves.new.title")}, :new_room_reserf_path, :only=>%w{new create}

  def index
    @reserves=current_user.reserves.ordered.paginate(:page=>params[:page])
  end

  def new
    @reserf= Reserf.new
  end

  def create
    @reserf= Reserf.new(params[:reserf]) 
    @reserf.room = @room
    if current_user.reserves <<  @reserf
      redirect_to reserves_path, :notice=>t("reserves.successfully_create")
    else
      render :action=>:new
    end
  end

  def edit 
  end

  def update
    if @reserf.update_attributes(params[:reserf])
      redirect_to reserves_path, :notice=>t("reserves.successfully_update")
    else
      render :action=>:edit
    end
  end

  def destroy
    @reserf.destroy
    redirect_to reserves_path, :notice=>t("reserves.successfully_destroy")
  end

  def publish
    authorize! :update, @reserf
    if @reserf.status < 1
      @reserf.change_status
    end
    redirect_to reserves_path
  end

  def change_status
    authorize! :manage, @reserf
    @reserf.change_status
    redirect_to reserves_path
  end

  def calculate
    authorize! :create, Reserf
    @reserf= Reserf.new(params[:reserf]) 
    @sum = @reserf.calculate(room)
  end


  private
  def find_reserve
    @reserf= Reserf.find(params[:id])
  end

  def find_hotel_and_room
    @room = Room.find(params[:room_id] || @reserf.room_id)
    @hotel = @room.hotel
    add_breadcrumb @hotel.name, hotel_path(@hotel)
    add_breadcrumb Room.places[ @room.places ].first, hotel_room_path(@hotel, @room)
  end
end
