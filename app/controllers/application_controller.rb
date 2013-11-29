class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :set_cookie
  before_filter :matchmaker_user
  after_filter :user_activity
  before_filter :authenticate
  before_filter :set_gettext_locale

  protect_from_forgery

  layout :layout_from_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def set_cookie
    cookies[:userid] = current_user.id if user_signed_in?
    cookies[:env] = Rails.env
  end
  private :set_cookie

  def user_activity
    current_user.try :touch
  end
  private :user_activity

  def authenticate
    if Rails.env.staging?
      authenticate_or_request_with_http_basic do |username, password|
        username == 'cellove' && password == 'c3ll0v3'
      end
    end
  end
  private :authenticate

  def layout_from_resource
    if user_signed_in?
      'logged_in'
    else
      'application'
    end
  end
end
