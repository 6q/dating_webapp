class RaterController < ApplicationController

  def create
    if current_user.present?
      @user = User.find(params[:id])
      current_user.rate params[:score].to_i, @user.id

      render :json => true
      add_to_cellove_index(params[:score].to_i)
    else
      render :json => false
    end
  end

  private
    def add_to_cellove_index(score)
      if score == 3
        @user.add_to_cellove_index(User::CELLOVE_3_STARS)
      elsif score == 4
        @user.add_to_cellove_index(User::CELLOVE_4_STARS)
      elsif score == 5
        @user.add_to_cellove_index(User::CELLOVE_5_STARS)
      end

      if current_user.is_nice_couple?(@user)
        @user.add_to_cellove_index(User::CELLOVE_COMMON_STARS)
      end
    end
end