class Time
  def get_month
    self.strftime("%m").to_s.delete("0").to_i 
  end
end

class ApplicationController < ActionController::Base
  include BreadcrumbsOnRails::ControllerMixin
  protect_from_forgery
  helper NavigationHelper
  helper_method :current_discount
  helper_method "admin?"


  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
     flash[:error] = t("access_denied")
      redirect_to root_url
    else
      authenticate_user!
    end
  end

private
  def admin?
    user_signed_in? && current_user.admin?
  end

  def logged_in
    authenticate_user!
  end

  def as_admin
    unless admin?
      flash[:alert] = t("access_denied")
      redirect_to root_path
      return false
    end
  end

end
