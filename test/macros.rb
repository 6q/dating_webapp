module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = :user
      @user = Factory.create(:user)
      sign_in @user
    end
  end
end