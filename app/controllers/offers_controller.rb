class OffersController < ApplicationController
  add_breadcrumb Proc.new{|c| c.t("offers.navigation")}, :offers_path

  def index
    @offers = Offer.ordered.paginate(:page => params[:page])
    @min_price = Offer.min_price
  end

  def show
    @offer = Offer.find(params[:id])
    @images = @offer.images
    add_breadcrumb @offer.name, offer_path(@offer)
  end

end
