class PicturesController < ApplicationController
  before_filter :find_picture, only: [:show, :destroy, :update]
  before_filter :check_ownership, only: [:update, :destroy]
  skip_before_filter :authenticate_user!
  skip_before_filter :matchmaker_user

  def create
    if current_user && current_user.is_over_picture_limit?
      render json: {error: _('Ya has alcanzado tu limite de fotos')}, status: 403
    else
      @picture = Picture.new(image: params["picture"])
      @picture.image = @picture.image.thumb("500x500").tempfile
      if current_user
        @picture.attachable = current_user
        if current_user.pictures.empty? || (params[:main] && params[:main] != 'undefined')
          current_user.pictures.update_all(main: false)
          @picture.main = true
        end
      end
      if @picture.save
        session[:registration_image] = @picture.id unless current_user

        render json: {
          crop_template: render_to_string(partial: 'pictures/picture_crop', locals: {picture: @picture}),
          update_path: picture_path(@picture)
        }
      end
    end
  end

  def update
    if cd = params[:crop_data]
      geometry = "#{cd[:w]}x#{cd[:h]}+#{cd[:x]}+#{cd[:y]}"
      @picture.image = @picture.image.thumb(geometry).tempfile
      @picture.save
    elsif main = params[:main]
      current_user.pictures.update_all(main: false)
      @picture.main = true
      @picture.save
      redirect_to :back
    end
    if current_user
      render json: {
        template: render_to_string(partial: 'pictures/picture_gallery', locals: {user: current_user}),
      }
    else
      render json: { 
        template: render_to_string(partial: 'pictures/registration_thumb', locals: { picture: @picture }) 
      }
    end
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
