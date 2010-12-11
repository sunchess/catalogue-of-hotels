class Hotels::ImagesController < ApplicationController
  before_filter :find_hotel
  before_filter :authorize_hotel, :exept=>[:index]

  def index
    @images = @hotel.images
  end

  def new
    @images = @hotel.images
  end
   
  def create
    unless params[:images].empty?
      params[:images].each do |image|
        image = Image.new(:image => image)
        if image.valid?
          @hotel.images << image
        end
      end
    flash[:notice] = t('hotels.images.successfully_create')
    end    
    redirect_to new_hotel_images_path(@hotel)
  end

private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id]) 
    if can? :update, @hotel
      @editable_flag = true
    end  
  end
  
  def authorize_hotel
    authorize! :update, @hotel
  end
end
