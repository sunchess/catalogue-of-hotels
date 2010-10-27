#require "action_view/helpers/url_helper"
module NavigationHelpers
  #include UrlHelper
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def new_session
    "users/sign_in"
  end

  def dynamic_models(action=nil)
     "/dynamic_models#{action ? "/#{action}" : nil}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
