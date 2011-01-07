class Hotels::ConfirmsController < ApplicationController
  before_filter :find_hotel
  before_filter :authorize_hotel

  def edit
    unless @hotel.has_all_params
      render :action=> "error"
    end 
  end

  def update
    unless params[:contract].blank?
      @hotel.contract = params[:contract]
      if @hotel.save
        @hotel.update_attribute(:confirmed, true)
        redirect_to edit_hotel_confirm_path(@hotel), :notice=>t("hotels.confirms.upload_succesfull")
      end
      
    else
      flash[:alert] = t("hotels.confirms.check_upload_file")
      redirect_to edit_hotel_confirm_path(@hotel)
    end
  end

  def error
    
  end

  private
  def find_hotel
    @hotel = Hotel.find(params[:hotel_id]) 
  end

  def authorize_hotel
    authorize! :update, @hotel
  end
end
