class DynamicFieldsController < ApplicationController
  load_and_authorize_resource
  before_filter :find_model
  caches_action :index, :edit_order
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
      redirect_to dynamic_model_dynamic_fields_path(@model), :notice=>t('dynamic_fields.successfully_create')
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
    if can? :update, DynamicField
      @dynamic_fields = DynamicField.where({:dynamic_model_id=>params[:dynamic_model_id]}).order("position")
    else
      raise CanCan::AccessDenied
    end

  end

  def update_order
    if can? :update, DynamicField
      @dynamic_fields = DynamicField.where({:dynamic_model_id=>params[:dynamic_model_id]}).order("position")
      order = params[:field]
      order.each_with_index do |id, idx|
       DynamicField.list_order(idx, id, @model.id)
      end
    else
      raise CanCan::AccessDenied
    end
    render :text => ""
  end

  private
  def find_model
    @model = DynamicModel.find(params[:dynamic_model_id])
  end

  def delete_cache
    expire_action :index
  end

  def delete_cache_order
    expire_action :edit_order
  end

end