class Admin::OffersController < ApplicationController
  before_filter :redirect_if_no_offer_agents, :only => %w{new create edit update}
  before_filter :find_offer, :only => %w{show edit update destroy}
  authorize_resource :offer

  def index
    @offers = Offer.ordered.paginate(:page=>params[:page])
  end

  def show
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(params[:offer])
    if @offer.save
      redirect_to edit_admin_offer_path(@offer), :notice => t("offers.successfully_create")
    else
      render :action => :new
    end
  end

  def edit
    @images = @offer.images
    @editable_flag = true
  end

  def update
    @images = @offer.images
    @editable_flag = true
    if @offer.update_attributes(params[:offer])
      redirect_to admin_offers_path, :notice => t("offers.successfully_update")
    else
      render :action => :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_to admin_offers_path, :notice => t("offers.successfully_destroy")
  end

  def update_order
    params[:offer].each do |id, pos|
      offer = Offer.find( id.to_i )
      #if offer.position != pos.to_i
        offer.insert_at( pos )
      #end
    end
    redirect_to admin_offers_path, :notice => t("admin.offers.successfully_order")
  end

  private
  def redirect_if_no_offer_agents
    @offer_agents = OfferAgent.all
    redirect_to new_admin_offer_agent_path, :notice => t("offers.error.mast_be_agent") unless @offer_agents.any?
  end

  def find_offer
    @offer = Offer.find(params[:id])
  end
end
