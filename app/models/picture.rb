# == Schema Information
#
# Table name: pictures
#
#  id              :integer          not null, primary key
#  image_uid       :string(255)
#  image_name      :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  main            :boolean          default(FALSE)
#

class Picture < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  attr_accessible :image

  image_accessor :image
  validates_size_of :image, maximum: 3.megabytes
  validates_property :format, of: :image, in: [:jpeg, :png, :gif]

  def to_json
    {
      thumb: image.thumb("80x").url,
      picture: self
    }.to_json
  end
end
