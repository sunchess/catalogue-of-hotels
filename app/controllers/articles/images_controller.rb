class Articles::ImagesController < ApplicationController
  protect_from_forgery :except => :create 
  def create
    authorize! :manage, Article
    image = Image.new(:image => params[:file], :draft=>false)
    if image.save
      render :text => image.image.url 
    else
      render :nothing => true
    end
  end
end
