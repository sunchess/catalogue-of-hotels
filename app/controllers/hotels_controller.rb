include Geokit::Geocoders

class HotelsController < ApplicationController
  before_filter :find_hotel, :only=>[:show, :edit, :update, :destroy]
  caches_action :index
  after_filter  :delete_cache, :only=>[:create, :update]
  before_filter :find_dynamic_fields, :only=>[:new, :create, :edit, :update]
  authorize_resource

  def index
    @hotels = Hotel.confirmed.paginate(:page=>params[:page])
  end

  def show
    #render show
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
      params[:fields].each do |field|
        @hotel.dynamic_fields << DynamicField.find_by_permalink(field)
      end if params[:fields]
      redirect_to(new_hotel_image_path(@hotel), :notice =>t('hotels.successfully_create')) 
    else
      render :action => "new" 
    end
  end

  def update
    @hotel.accessible = [ :draft, :paid_placement ] if admin?
    if @hotel.update_attributes(params[:hotel])
      if params[:fields]
        params[:fields].each do |field|
          @hotel.dynamic_fields << DynamicField.find_by_permalink(field)
        end 
      else
        @hotel.dynamic_fields.clear
      end 
      redirect_to(edit_hotel_path(@hotel), :notice => t('hotels.successfully_update'))
    else
      render :action => "edit" 
    end
  end

  def destroy
    @hotel.destroy

    respond_to do |format|
      format.html { redirect_to(hotels_url) }
      format.xml  { head :ok }
    end
  end

private
  def find_hotel
    @hotel = Hotel.find(params[:id])
  end
  
  def find_dynamic_fields
    @dynamic_fields = DynamicModel.return_dynamic_fields("Hotel")
  end

  def delete_cache
    expire_action :index
  end
end
