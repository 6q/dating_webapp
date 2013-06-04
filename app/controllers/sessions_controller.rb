#encoding: utf-8
class SessionsController < Devise::SessionsController

  def new
    flash[:error] = _('MESSAGE HERE')
    redirect_to root_path
  end

end
