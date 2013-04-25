class ProfilesController < ApplicationController
  layout 'logged_in'

  def show
    @user = current_user
  end

  def update
  	@user = current_user
    if @user.update_attributes(params[:user])
      render 'show' , :notice => "User updated."
    else
      render 'show', :alert => "Unable to update user."
    end
  end
end
