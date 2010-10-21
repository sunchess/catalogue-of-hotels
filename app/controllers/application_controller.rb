class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
     flash[:error] = t("access_denied")
      redirect_to root_url
    else
      authenticate_user!
    end
  end
end
