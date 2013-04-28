class PicturesController < ApplicationController
  def create
    @picture = Picture.new(image: params["picture"])
    @picture.attachable = current_user
    if @picture.save
      render json: {
        gallery_partial: render_to_string(partial: 'pictures/picture_gallery', locals: {user: current_user}),
        picure: @picture.to_json
      }
    end
  end

  def show
    @picture = Picture.find(params[:id])
  end
end
