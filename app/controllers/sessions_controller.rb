#encoding: utf-8
class SessionsController < Devise::SessionsController

  def new
    flash[:error] = _('Email o contraseña inválidos')
    redirect_to root_path
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

end
