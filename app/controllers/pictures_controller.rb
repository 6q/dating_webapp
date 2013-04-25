class PicturesController < ApplicationController
  def create
    @picture = Picture.new(image: params["picture"])
    if @picture.save
      render json: @picture
    else
      render json: []
    end
  end
end
