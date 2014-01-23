#encoding: utf-8
class UserConfirmationsController < Devise::ConfirmationsController
  
  before_filter :check_if_confirmed
  
  
  
  private
    
    def check_if_confirmed
      u = User.find_by_confirmation_token(params[:confirmation_token])
      unless u
        redirect_to root_url, :alert => _('No hemos podido confirmar tu cuenta. Si ya la habías confirmado identificate para continuar.')
      end
    end
  
end