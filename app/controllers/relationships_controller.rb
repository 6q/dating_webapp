class RelationshipsController < ApplicationController
  def like
    @user = User.find(params[:user_id])
    if @user
      @like = current_user.likes.build({})
      @like.user_id = @user.id
      @like.save
    else
      flash[:error] = "Err."
    end
    redirect_to dashboard_path
  end

  def block
  end
end
