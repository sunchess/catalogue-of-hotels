class Time
  def get_month
    self.strftime("%m").to_s.delete("0").to_i 
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper NavigationHelper

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
    current_user.admin?
  end

  def logged_in
    authenticate_user!
  end
end
