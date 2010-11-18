module ControllerMacros
  def login_admin
    before do
      @current_user = Factory.create(:admin)
      sign_in @current_user
    end
  end
end
