include Geokit::Geocoders

class PlacesController < ApplicationController
  autocomplete :place, :title

  before_filter :find_place, :only=>[:edit, :update, :destroy, :show]
  before_filter :transrorm_for_autocomplete, :only => :autocomplete_place_title

  authorize_resource
  add_breadcrumb Proc.new{|c| c.t("places.index.title")}, :places_path#, :only=>%w{show new edit create update}
  add_breadcrumb Proc.new{|c| c.t("places.new.title")}, :new_place_path, :only=>%w{new create}
  add_breadcrumb Proc.new{|c| c.t("places.edit.title")}, :edit_place_path, :only=>%w{edit update}

  caches_action :index, :layout=>false, :cache_path => :index_cache_path.to_proc

  after_filter :delete_cache, :only=>[:update, :create, :destroy]
  before_filter :find_parents_and_fields, :only=>[:new, :edit, :create, :update]

  def index
    if can?(:manage, Place)
      @places = Place.where(:parent_id=>nil).includes([:children]).order(:position)
    else
      @places = Place.where(:parent_id=>nil, :draft=>false).includes([:children]).order(:position)
    end
    @place = Place.new
  end

  def show
    if @place.parent
      @geo_place = "#{@place.title}, #{@place.parent.title}"
      add_breadcrumb @place.parent.title, place_path(@place.parent)
      add_breadcrumb @place.title, place_path(@place)
    else
      @geo_place = @place.title
      add_breadcrumb @place.title, place_path(@place)
    end

    @gg_locate = GoogleGeocoder.geocode(@geo_place)
    @place_map =  YandexMap.new
    @map = Map.new

    #for form
    @image = Image.new

    @images = if can? :manage, Image
                @place.images.limited
              else
                @place.images.not_draft.limited
              end
  end


  def new
    @place = Place.new
  end


  def edit
    #render edit
  end

  def create
    @place = Place.new
    @place.accessible = [ :draft, :paid_placement ] if admin?
    @place.attributes = params[:place]

    @place.draft = true

    if @place.save
      @place.save_dynamic_fields( params[:fields] )
      redirect_to places_path, :notice=>t('places.successfully_create')
    else
      render :action => "new"
    end
  end

  def update
    @place.accessible = [ :draft, :paid_placement ] if admin?
    if @place.update_attributes(params[:place])
      @place.save_dynamic_fields( params[:fields] )
      redirect_to(@place, :notice => t('places.successfully_update'))
    else
      render :action => "edit"
    end
  end


  def destroy
    @place.destroy
    redirect_to(places_url, :notice => t('places.successfully_destroy'))
  end

  def quick_search
    @place = Place.where(:title => params[:title]).first
    redirect_to place_path(@place)
  end

private
  def find_parents_and_fields
    @parents = Place.where({:draft=>false, :parent_id=>nil}).order("parent_id, position").all
    @dynamic_fields = DynamicModel.return_dynamic_fields("Place")
  end

  def delete_cache
   expire_fragment(/admin\/places\/*/)
   expire_fragment(/public\/places\/*/)
  end

  def find_place
    @place = Place.find(params[:id])
  end

  def index_cache_path
    if can?(:manage, Place)
      'admin/places'
    else
      'public/places'
    end
  end

  def transrorm_for_autocomplete
    params[:term] = params[:term].mb_chars.capitalize.to_s
    p params[:term]
  end

end

