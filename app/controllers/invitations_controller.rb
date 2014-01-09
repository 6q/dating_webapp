#encoding: utf-8
class InvitationsController < ApplicationController

  def create
    invitation = current_user.invitations.build(params[:invitation])
    invitation.invitation_code = SecureRandom.urlsafe_base64
    if invitation.save
      if params[:invitation][:user_type] == 'regular_user'
        # Send regular user invitation email
        current_user.add_to_cellove_index(2)
        UserMailer.invite_user(current_user, params[:invitation][:invited_email], invitation.invitation_code).deliver
        flash[:success] = _('¡Usuari@ invitado!')
      elsif params[:invitation][:user_type] == 'celestino'
        # Send celestino invitation email
        current_user.add_to_cellove_index(1)
        UserMailer.invite_celestino(current_user, params[:invitation][:invited_email], invitation.invitation_code).deliver
        flash[:success] = _('¡Celestin@ invitado!')
      end
    else
      # Something went wrong.
      flash[:error] = _('Oops!')
    end
    redirect_to my_matchmakers_path(anchor: 'mejora')
  end

end
