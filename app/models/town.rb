# == Schema Information
#
# Table name: towns
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  longitude   :float
#  latitude    :float
#  region_id   :integer
#  province_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Town < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name
end
