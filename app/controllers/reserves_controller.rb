class ReservesController < ApplicationController
  before_filter :find_reserve, :only=>[:show, :edit, :update, :destroy]
  authorize_resource :reserf
  before_filter :find_hotel_and_room, :only=>%w{ new create edit update publish }
  add_breadcrumb Proc.new{|c| c.t("reserves.new.title")}, :new_reserf_path, :only=>%w{new create}

  def index
    @reserves=current_user.reserves.paginate(:page=>params[:page])
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
    
  end

  def destroy
    
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


  private
  def find_reserve
    @reserf= Reserf.find(params[:id])
  end

  def find_hotel_and_room
    @room = Room.find(params[:room])
    @hotel = @room.hotel
    add_breadcrumb @hotel.name, hotel_path(@hotel)
    add_breadcrumb t("rooms.navigation"), hotel_rooms_path(@hotel)
  end
end
