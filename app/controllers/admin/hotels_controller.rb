class Admin::HotelsController < ApplicationController
  before_filter :as_admin

  def index
    @hotels = Hotel.confirmed
  end

  def order
    @hotels = Hotel.public_items.paginate(:page => params[:page])
  end

  def update_order
    params[:hotels].each do |id, pos|
      hotel = Hotel.find( id.to_i )
      if hotel.position != pos.to_i
        hotel.insert_at( pos )
      end
    end
    redirect_to order_admin_hotels_path, :notice => t("admin.hotels.successfully_order")
  end

end
