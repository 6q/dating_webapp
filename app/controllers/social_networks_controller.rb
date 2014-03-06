class SocialNetworksController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: :update
  skip_before_filter :matchmaker_user
  skip_before_filter :check_if_must_complete_fields

  def new
    @geocoder = Geocoder.search(request.env["HTTP_CF_CONNECTING_IP"]).first
    @sn       = env["omniauth.auth"]
  end

end
