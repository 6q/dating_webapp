class Picture < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  attr_accessible :image

  image_accessor :image
end
