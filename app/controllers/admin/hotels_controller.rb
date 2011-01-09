class Admin::HotelsController < ApplicationController
  before_filter :as_admin

  def index
    @hotels = Hotel.confirmed
  end

end
