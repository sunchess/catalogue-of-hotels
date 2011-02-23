class ArticlesController < ApplicationController
  before_filter :find_association
  before_filter :find_article, :only => %w{show edit update destroy}
  before_filter :add_association_bread_crambs, :only => %w[show edit update create destroy]
  before_filter :article_breadcrumb, :only => %w[show edit update]
  authorize_resource :article
  caches_action :index, :layout => false, :cache_path => :index_cache_path.to_proc
  after_filter :delete_cache, :only => [:create, :update, :destroy]

  def index
    if @place
      @articles = @place.articles.paginate(:page=>params[:page])
      add_breadcrumb t("articles.index.title"), place_articles_path(@place)
    elsif @hotel
    else
      @articles = Article.order("id Desc").paginate(:page => params[:page])
    end
  end

  def show; end

  def new
    @article = Article.new
    add_breadcrumb t("articles.new.title"), new_place_article_path
  end
  
  def create
    @article = Article.new(params[:article])
    @article.articleable = @place || @hotel
    if @article.save
      redirect_to @article, :notice => t("articles.successfully_create")
    else
      render :action => :new
    end
  end

  def edit; end

  def update
    if @article.update_attributes(params[:article])
      redirect_to @article, :notice => t("articles.successfully_update")
    else
      render :action => :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, :notice => t("articles.successfully_destroy")
    else
      redirect_to articles_path, :notice => t("articles.destroy_error")
    end
  end
  
  private
  def find_article
    @article = Article.find(params[:id])
  end

  def article_breadcrumb
    add_breadcrumb @article.title, article_path(@article)
  end

  def add_association_bread_crambs
    if association = @article.articleable
      if association.is_a? Place
        add_breadcrumb association.title, place_path(association) 
        add_breadcrumb t("articles.index.title"), place_articles_path(association)
      end
    end
  end
  
  def find_association    
    if params[:place_id]
      @place = Place.find(params[:place_id])
      add_breadcrumb @place.title, place_path(@place)
    end
  end

  def find_another_articles
    
  end

  def delete_cache
    association = @article.articleable
    if association.is_a? Place
      expire_fragment %r{admin\/places\/#{association.id}\/articles/*}
      expire_fragment %r{public\/places\/#{association.id}\/articles\/*}
    elsif association.is_a? Hotel
      expire_fragment %r{admin\/hotels\/#{association.id}\/articles\/*}
       expire_fragment %r{public\/hotels\/#{association.id}\/articles\/*}
    else
      expire_fragment %r{admin\/articles\/*}
      expire_fragment %r{public\/articles\/*}
    end
  end

  def index_cache_path
    if can?(:manage, Article)
      if @place
        if params[:page]
          "admin/places/#{@place.id}/articles/#{params[:page]}"
        else
          "admin/places/#{@place.id}/articles/1"
        end
      elsif @hotel
        if params[:page]
          "admin/hotels/#{@hotel.id}/articles/#{params[:page]}"
        else
          "admin/hotels/#{@hotel.id}/articles/1"
        end
      else
        if params[:page]
          "admin/articles/#{params[:page]}"
        else
          "admin/articles/1"
        end
      end
    else
      if @place
        if params[:page]
          "public/places/#{@place.id}/articles/#{params[:page]}"
        else
          "public/places/#{@place.id}/articles/1"
        end
      elsif @hotel
        if params[:page]
          "public/hotels/#{@hotel.id}/articles/#{params[:page]}"
        else
          "public/hotels/#{@hotel.id}/articles/1"
        end
      else
        if params[:page]
          "public/articles/#{params[:page]}"
        else
          "public/articles/1"
        end
      end
    end
  end

end
