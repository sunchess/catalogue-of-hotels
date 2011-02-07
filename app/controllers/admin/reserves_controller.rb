class Admin::ReservesController < ApplicationController
  before_filter :as_admin

  def index
    @reserves = Reserf.statused(params[:status] || 0).ordered.paginate(:page=>params[:page])
  end

end
