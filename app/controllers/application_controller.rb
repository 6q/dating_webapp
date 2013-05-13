class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :matchmaker_user
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end
