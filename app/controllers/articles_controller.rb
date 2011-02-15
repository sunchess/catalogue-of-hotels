class ArticlesController < ApplicationController
  before_filter :find_association
  authorize_resource
  caches_action :index, :layout => false, :cache_path => :index_cache_path.to_proc

  def index
    @place.articles.paginate(:page=>params[:page])
  end

  def new
    @article = Article.new
  end
  
  private
  def find_association    
    if params[:place_id]
      @place = Place.find(params[:place_id])
      add_breadcrumb @place.title, place_path(@place)
      add_breadcrumb t("articles.new.title"), new_place_article_path
    end
  end

  def index_cache_path
    if can?(:manage, Article)
      if params[:page]
        "admin/places/#{params[:page]}"
      else
        "admin/places"
      end
    else
      if params[:page]
        "public/places#{params[:page]}"
      else
        'public/places'
      end
    end
  end
end
