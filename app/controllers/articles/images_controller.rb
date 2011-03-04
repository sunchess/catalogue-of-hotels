class Articles::ImagesController < ApplicationController
  before_filter :find_article, :only => [:create, :destroy]
  protect_from_forgery :except => :create_image 

  def create
    if params[:images] and !params[:images].empty?
      params[:images].each do |image|
        image = Image.new(:image => image, :draft=>false)
        if image.valid?
          @article.images << image
          flash[:notice] = t('articles.images.successfully_create') unless flash[:notice]
        else
          flash[:alert] = image.errors.full_messages.join("; ")
        end
      end
    end    
    redirect_to edit_article_path(@article)
  end

  def destroy
    images_ids = params[:images].map(&:to_i)
    Image.destroy_all(["id IN(?) and imageable_type ='Article' and imageable_id=?", images_ids, @article.id])
    flash[:notice] = t('places.images.form.successfully_destroy')
    redirect_to edit_article_path(@article)
  end

  def create_image
    authorize! :manage, Article
    image = Image.new(:image => params[:file], :draft=>false)
    if image.save
      render :text => image.image.url 
    else
      render :nothing => true
    end
  end

  private
  def find_article
    @article = Article.find(params[:article_id])
  end
end
