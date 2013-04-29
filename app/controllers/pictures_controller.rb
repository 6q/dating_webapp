class PicturesController < ApplicationController
  layout 'logged_in'
  before_filter :find_picture, only: [:show, :destroy, :update]
  before_filter :check_ownership, only: [:update, :destroy]

  def create
    if current_user.is_over_picture_limit?
      render json: {error: 'Ya has alcanzado tu limite de fotos'}, status: 403
    else
      @picture = Picture.new(image: params["picture"])
      @picture.image = @picture.image.thumb("500x500").tempfile
      @picture.attachable = current_user
      if @picture.save
        render json: {
          crop_template: render_to_string(partial: 'pictures/picture_crop', locals: {picture: @picture}),
          update_path: picture_path(@picture)
        }
      end
    end
  end

  def update
    cd = params[:crop_data]
    if cd
      geometry = "#{cd[:w]}x#{cd[:h]}+#{cd[:x]}+#{cd[:y]}"
      @picture.image = @picture.image.thumb(geometry).tempfile
      @picture.save
    end
    render json: {
      gallery_template: render_to_string(partial: 'pictures/picture_gallery', locals: {user: current_user}),
    }
  end

  def show
  end

  def destroy
    @picture.destroy
    redirect_to :back
  end

  private
  def find_picture
    @picture = Picture.find(params[:id])
  end

  def check_ownership
    unless @picture.attachable == current_user
      flash[:warning] = _("No tienes permiso para borrar esta foto")
      redirect_to profile_path
    end
  end
end
