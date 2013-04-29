class PicturesController < ApplicationController
  before_filter :find_picture, only: [:show, :destroy]

  def create
    if current_user.is_over_picture_limit?
      render json: {error: 'Ya has alcanzado tu limite de fotos'}, status: 403
    else
      @picture = Picture.new(image: params["picture"])
      @picture.attachable = current_user
      if @picture.save
        render json: {
          gallery_partial: render_to_string(partial: 'pictures/picture_gallery', locals: {user: current_user}),
          picure: @picture.to_json
        }
      end
    end
  end

  def show
  end

  def destroy
    if @picture.attachable == current_user
      @picture.destroy
    else
      flash[:warning] = _("No tienes permiso para borrar esta foto")
    end
    redirect_to :back
  end

  private
  def find_picture
    @picture = Picture.find(params[:id])
  end
end
