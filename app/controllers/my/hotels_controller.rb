class My::HotelsController < ApplicationController
  before_filter :logged_in

  def index
    @hotels = current_user.hotels.paginate(:page=>params[:page])
  end

end
