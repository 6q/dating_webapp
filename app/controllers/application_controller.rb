class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :set_session
  before_filter :set_cookie
  before_filter :matchmaker_user
  after_filter :user_activity
  before_filter :authenticate
  before_filter :set_gettext_locale
  before_filter :prepare_for_mobile

  has_mobile_fu(false)

  protect_from_forgery

  layout :layout_from_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # Continue rendering HTML for tablets (no mobile views yet)
  def force_tablet_html
      session[:tablet_view] = false
  end

  def set_session
    unless user_signed_in? or session[:cookies_accepted]
      @show_cookies_warning       = true
      session[:cookies_accepted]  = true
    end
  end
  private :set_session

  def set_cookie
    cookies[:userid] = current_user.id if user_signed_in?
    cookies[:env] = Rails.env
    cookies[:locale] = params[:locale] ? params[:locale] : I18n.locale.to_s
  end
  private :set_cookie

  def user_activity
    current_user.try :touch
  end
  private :user_activity

  def authenticate
    if Rails.env.staging? or Rails.env.mobile?
      authenticate_or_request_with_http_basic do |username, password|
        username == 'cellove' && password == 'c3ll0v3'
      end
    end
  end
  private :authenticate

  def prepare_for_mobile

    # change when the mobile version is ready to go
    #session[:mobile_view] = is_mobile_device? if session[:mobile_view].nil?
    session[:mobile_view] = false if session[:mobile_view].nil?
      
    if params[:mobile] == 'true'
      session[:mobile_view] = true
    elsif params[:mobile] == 'false'
      session[:mobile_view] = false
    end

    if session[:mobile_view] == true  && !request.xhr?
      request.format = :mobile
    end

  end

  def layout_from_resource
    if user_signed_in?
      'logged_in'
    else
      'application'
    end
  end
end
