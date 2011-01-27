include Geokit::Geocoders

class HotelsController < ApplicationController
  add_breadcrumb Proc.new{|c| c.t("hotels.navigation")}, :hotels_path

  before_filter :find_hotel, :only=>[:show, :edit, :update, :destroy]
  add_breadcrumb Proc.new{|c| c.t("hotels.edit.title")}, :edit_hotel_path, :only=>%w{edit update}
  add_breadcrumb Proc.new{|c| c.t("hotels.new.title")}, :new_hotel_path, :only=>%w{new create}

  #caches_action :index, :layout=>false
  after_filter  :delete_cache, :only=>[:create, :update]
  before_filter :find_dynamic_fields, :only=>[:new, :create, :edit, :update]
  authorize_resource

  def index
    @hotels = Hotel.public_items.paginate(:page=>params[:page], :per_page=>10)
  end

  def show
    #render show
    @images = @hotel.images.limit(3)
  end

  def new
    @hotel = Hotel.new
  end

  def edit
    #renfer edit template
  end

  def create
    @hotel = Hotel.new
    @hotel.accessible = [ :draft, :paid_placement ] if admin?
    @hotel.attributes = params[:hotel]
    if current_user.hotels << @hotel
      @hotel.save_dynamic_fields( params[:fields] )
      redirect_to(new_hotel_image_path(@hotel), :notice =>t('hotels.successfully_create')) 
    else
      render :action => "new" 
    end
  end

  def update
    @hotel.accessible = [ :draft, :paid_placement ] if admin?
    if @hotel.update_attributes(params[:hotel])
      @hotel.save_dynamic_fields( params[:fields] )
      redirect_to(edit_hotel_path(@hotel), :notice => t('hotels.successfully_update'))
    else
      render :action => "edit" 
    end
  end


private
  def find_hotel
    @hotel = Hotel.find(params[:id])
    add_breadcrumb @hotel.name, hotel_path(@hotel)
  end
  
  def find_dynamic_fields
    @dynamic_fields = DynamicModel.return_dynamic_fields("Hotel")
  end

  def delete_cache
    expire_action :action=>:index
  end
end
