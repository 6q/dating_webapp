class SocialNetworksController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: :update
  skip_before_filter :matchmaker_user
  skip_before_filter :check_if_must_complete_fields

  def new
    @sn       = env["omniauth.auth"]
    user      = User.from_omniauth(@sn)

    sign_in_and_redirect user, :event => :authentication if user

    @geocoder = Geocoder.search(request.env["HTTP_CF_CONNECTING_IP"]).first
  end

end
