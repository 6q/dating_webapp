#encoding: utf-8
class SessionsController < Devise::SessionsController

  def new
    flash[:error] = _('Email o contraseño inválidos')
    redirect_to root_path
  end

end
