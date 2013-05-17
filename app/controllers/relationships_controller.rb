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

  def block_hide
    user_block = params[:user_block][:blocked_user_id]
    user_hide = params[:user_hide][:hidden_user_id]
    user = User.find(params[:user_id])

    if user
      if user_block == "1"
        current_user.user_blocks.create({ blocked_user_id: user.id })
      else
        user_blocked = current_user.user_blocks.where("blocked_user_id = ?", user.id).first
        if !user_blocked.nil?
          user_blocked.delete
        end
      end
      if user_hide == "1"
        current_user.user_hides.create({ hidden_user_id: user.id })
      else
        user_hidden = current_user.user_hides.where("hidden_user_id = ?", user.id).first
        if !user_hidden.nil?
          user_hidden.delete
        end
      end
      redirect_to dashboard_path
    end
  end
end
