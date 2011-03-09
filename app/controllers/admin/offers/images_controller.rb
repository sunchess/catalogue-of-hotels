class Admin::Offers::ImagesController < ApplicationController
  before_filter :find_offer, :only => [:create, :destroy]
  protect_from_forgery :except => :create_image 

  def create
    if params[:images] and !params[:images].empty?
      params[:images].each do |image|
        image = Image.new(:image => image, :draft=>false)
        if image.valid?
          @offer.images << image
          flash[:notice] = t('offers.images.successfully_create') unless flash[:notice]
        else
          flash[:alert] = image.errors.full_messages.join("; ")
        end
      end
    end    
    redirect_to edit_admin_offer_path(@offer)
  end

  def destroy
    images_ids = params[:images].map(&:to_i)
    Image.destroy_all(["id IN(?) and imageable_type ='Offer' and imageable_id=?", images_ids, @offer.id])
    flash[:notice] = t('offers.images.successfully_destroy')
    redirect_to edit_admin_offer_path(@offer)
  end


  private
  def find_offer
    @offer = Offer.find(params[:offer_id])
  end
end
