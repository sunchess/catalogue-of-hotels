class Admin::ReservesController < ApplicationController
  before_filter :as_admin
  before_filter :find_reserve, :only => %w{ update destroy}

  def index
    @reserves = Reserf.statused(params[:status] || 0).ordered.paginate(:page=>params[:page])
  end

  def update
    @reserve.update_attribute(:status, @reserve.status + 1)
    redirect_to admin_reserves_path(:status => params[:status])
  end

  def destroy
    @reserve.update_attribute(:status, 6)
    redirect_to admin_reserves_path(:status => params[:status])
  end

  private
  def find_reserve
    @reserve = Reserf.find(params[:id])
  end

end
