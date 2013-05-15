class ProfilesController < ApplicationController
  layout 'logged_in'
  skip_before_filter :matchmaker_user
  before_filter :skip_password_attribute, only: :update

  def show
    @user = current_user
    if @user.has_role?(:matchmaker)
      @recommendation = Recommendation.new
      @characteristic = Characteristic.new

      render 'matchmaker_show'
    else
      render 'show'
    end
  end

  def update
  	@user = current_user
    if @user.update_attributes!(params[:user])
      if @user.has_role?(:matchmaker)
        @recommendation = Recommendation.new
        @characteristic = Characteristic.new

        render 'matchmaker_show'
      else
        render 'show', :notice => "User updated."
      end
    else
      if @user.has_role?(:matchmaker)
        @recommendation = Recommendation.new
        @characteristic = Characteristic.new

        render 'matchmaker_show', :alert => "Unable to update user."
      else
        render 'show', :alert => "Unable to update user."
      end
    end
  end

  private
    def skip_password_attribute
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].except!(:password, :password_confirmation)
      end
    end
end
