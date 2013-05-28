class InvitationsController < ApplicationController

  def create
    invitation = Invitation.new(params[:invitation])
    if invitation.save
      # Success flash message
    end
  end

end
