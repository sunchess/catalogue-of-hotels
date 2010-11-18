class Places::ImagesController < ApplicationController
  load_and_authorize_resource
  before_filter :find_place

  def index
    @image = Image.new
    @images = if can? :manage, Image
                @place.images
              else
                @place.images.not_draft
              end
  end

  def create
    @image = Image.new(:image => params[:image])
    if @image.valid?
      @place.images << @image
    end
    redirect_to place_images_path(@place), :notice=>t('places.images.form.successfully_create')
  end

  def update
    images_ids = params[:images].map{|id| id.to_i}
    if params[:publish]
      Image.update_all({:draft=>false}, ["id IN(?)", images_ids])
      flash[:notice] = t('places.images.form.successfully_update')
    elsif params[:destroy]
      Image.destroy_all(["id IN(?)", images_ids])
      flash[:notice] = t('places.images.form.successfully_destroy')
    end
    redirect_to place_images_path(@place)

  end

  private
  def find_place
    @place = Place.find(params[:place_id])
  end
end
