class Picture < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  attr_accessible :image

  image_accessor :image

  def to_json
    {
      thumb: image.thumb("80x").url,
      picture: self
    }.to_json
  end
end
