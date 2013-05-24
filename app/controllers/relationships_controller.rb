class RelationshipsController < ApplicationController

  def like
    @user = User.find(params[:user_id])
    if @user
      current_user.like(@user)
    else
      flash[:error] = "Err."
    end
    redirect_to dashboard_path
  end

  def block_hide
    user_block = params[:user_block][:blocked_user]
    user_hide = params[:user_hide][:hidden_user]
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
    end
    redirect_to dashboard_path
  end

  def block_hide_settings
    params[:user].each do |user|
      if user[1]["hidden_user"] == "1"
        current_user.user_hides.create({ hidden_user_id: user[0] })
      else
        user_hidden = current_user.user_hides.where("hidden_user_id = ?", user[0]).first
        if !user_hidden.nil?
          user_hidden.delete
        end
      end

      if user[1]["blocked_user"] == "1"
        current_user.user_blocks.create({ blocked_user_id: user[0] })
      else
        user_blocked = current_user.user_blocks.where("blocked_user_id = ?", user[0]).first
        if !user_blocked.nil?
          user_blocked.delete
        end
      end
    end
    redirect_to settings_path
  end

end
