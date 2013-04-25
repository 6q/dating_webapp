class Picture < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  image_accessor :image
end
