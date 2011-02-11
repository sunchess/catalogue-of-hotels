class DynamicFieldsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_model
  #caches_action :index, :edit_order, :layout=>false #path with pagenate not work
  before_filter :delete_cache, :only=>[:create, :update, :destroy]
  before_filter :delete_cache_order, :only => [:update_order]
  
  def index
    @dynamic_fields = DynamicField.where({:dynamic_model_id=>@model.id}).order("position").paginate(:page=>params[:page])
  end

  def new
    @dynamic_fields = DynamicField.new
  end
  
  def edit
    #render edit
  end

  def create
    @dynamic_field = DynamicField.new(params[:dynamic_field])
    if @dynamic_field.valid?
      @model.dynamic_fields << @dynamic_field
      redirect_to new_dynamic_model_dynamic_field_path(@model), :notice=>t('dynamic_fields.successfully_create')
    else
      render :action=>"new"
    end
  end

  def update
    if @dynamic_field.update_attributes(params[:dynamic_field])
      redirect_to dynamic_model_dynamic_fields_path(@model), :notice=>t('dynamic_fields.successfully_update')
    else
      render :action=>"edit"
    end
  end

  def destroy
    if @dynamic_field.destroy
      redirect_to dynamic_model_dynamic_fields_path(@model), :notice => t('dynamic_fields.successfully_destroy')
    else
      flash[:error] = t("error")
      redirect_to dynamic_model_dynamic_fields_path(@model)
    end
  end

  def edit_order
      @dynamic_fields = DynamicField.where({:dynamic_model_id=>params[:dynamic_model_id]}).order("position")
      authorize! :update, @dynamic_fields
  end

  def update_order
    @dynamic_fields = DynamicField.where({:dynamic_model_id=>params[:dynamic_model_id]}).order("position")
    
    authorize! :update, @dynamic_fields

    order = params[:field]
    order.each_with_index do |id, idx|
     DynamicField.list_order(idx, id, @model.id)
    end
    render :text => ""
  end

  private
  def find_model
    @model = DynamicModel.find(params[:dynamic_model_id])
  end

  def delete_cache
    expire_action :action=>:index
  end

  def delete_cache_order
    expire_action :action=>:edit_order
  end

end
