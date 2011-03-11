class HomeController < ApplicationController
  def index
    @rooms = Room.ad
    @offers = Offer.ad
    @articles = Article.lasts
  end

end
