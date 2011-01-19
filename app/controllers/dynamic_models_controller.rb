class DynamicModelsController < ApplicationController
  
  load_and_authorize_resource
  caches_action :index, :layout=>false
  before_filter :delete_cache, :only=>[:create, :update, :destroy]


  def index
    @dynamic_models = DynamicModel.all
  end

  def new
   @dynamic_model = DynamicModel.new
  end

  def edit
    #render edit
  end

  def create
    @dynamic_model = DynamicModel.new params[:dynamic_model]
    if @dynamic_model.save
      redirect_to dynamic_models_path, :notice=>t('dynamic_models.successfully_create')
    else
      render :action => :new
    end
  end

  def update
    if @dynamic_model.update_attributes(params[:dynamic_model])
      redirect_to dynamic_models_path, :notice=>t('dynamic_models.successfully_update')
    else
      render :action=>:edit
    end
  end

  def destroy
    if @dynamic_model.destroy
      redirect_to dynamic_models_path, :notice => t('dynamic_models.successfully_destroy')
    else
      flash[:error] = t("error")
      redirect_to dynamic_models_path, :notice => t('dynamic_models.successfully_destroy')
    end
  end

  private
  def delete_cache
    expire_action :action=>:index
  end


end
