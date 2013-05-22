class RaterController < ApplicationController

  def create
    if current_user.present?
      @user = User.find(params[:id])
      current_user.rate params[:score].to_i, @user

      render :json => true
    else
      render :json => false
    end
  end

end