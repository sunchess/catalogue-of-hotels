class Admin::OfferAgentsController < ApplicationController
  before_filter :find_agent, :only => %w{show edit update destroy}
  authorize_resource :offer_agent

  def index
    @offer_agents = OfferAgent.all
  end

  def show
  end

  def new
    @offer_agent = OfferAgent.new
  end

  def create
    @offer_agent = OfferAgent.new params[:offer_agent]
    if @offer_agent.save
      redirect_to admin_offer_agents_path, :notice => t("offers.agents.successfully_create")
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @offer_agent.update_attributes(params[:offer_agent])
      redirect_to admin_offer_agents_path, :notice => t("offers.agents.successfully_update")
    else
      render :action => :edit
    end
  end

  def destroy
    @offer_agent.destroy
    redirect_to admin_offer_agents_path, :notice => t("offers.agents.successfully_destroy")
  end

  private
  def find_agent
    @offer_agent = OfferAgent.find(params[:id])
  end
end
