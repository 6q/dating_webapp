class UserProfileController < ApplicationController
  layout "layouts/logged_in"

  def edit
    @user = current_user
  end

  def update
  	@user = current_user
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def update_password
    redirect_to users_path, :notice => "Ulaa"
  end

end

