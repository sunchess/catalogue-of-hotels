include Geokit::Geocoders

class HotelsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_place
  #caches_action :index #Thinking how to delete cache with deferent params
  before_filter :find_dynamic_fields, :only=>[:new, :create, :edit, :update]

  def index
    @hotels =if @place
               Hotel.public.paginate(:page=>params[:page])
             else
               Hotel.public.paginate(:page=>params[:page])
             end
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
    @hotel.accessible = :draft if admin?
    @hotel.attributes = params[:place]
    if @hotel.save
      params[:fields].each do |field|
        @hotel.dynamic_fields << DynamicField.find_by_permalink(field)
      end if params[:fields]
      redirect_to(@hotel, :notice =>t('hotels.sea')) 
    else
      render :action => "new" 
    end
  end

  def update
    if @hotel.update_attributes(params[:hotel])
      if params[:fields]
        params[:fields].each do |field|
          @hotel.dynamic_fields << DynamicField.find_by_permalink(field)
        end 
      else
        @hotel.dynamic_fields.clear
      end 
      redirect_to(@hotel, :notice => 'Hotel was successfully updated.')
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
  def find_place
    if params[:place_id]
      @place = Place.find(params[:place_id])
    end
  end
  
  def find_dynamic_fields
    @dynamic_fields = DynamicModel.return_dynamic_fields("Hotel")
  end
end
