class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

end
