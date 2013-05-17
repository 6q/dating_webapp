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
    logger.debug "USERBLOCK IS CHECKED?"
    logger.debug user_block
    logger.debug "USERHIDE IS CHECKED?"
    logger.debug user_hide

    if user
      if user_block == "1"
        current_user.user_blocks.create({ blocked_user_id: user.id })
      else
        user_blocked = current_user.user_blocks.where("blocked_user_id = ?", user.id).first
        if !user_blocked.nil?
          logger.debug "DELETING USERBLOCK!!!!!!"
          user_blocked.delete
          logger.debug user_blocked.errors.inspect if user_blocked.errors
        end
      end
      if user_hide == "1"
        current_user.user_hides.create({ hidden_user_id: user.id })
      else
        user_hidden = current_user.user_hides.where("hidden_user_id = ?", user.id).first
        if !user_hidden.nil?
          logger.debug "DELETING USERHIDDEN!!!!!!"
          user_hidden.delete
          logger.debug user_hidden.errors.inspect if user_hidden.errors
        end
      end
      redirect_to dashboard_path
    end
  end
end
