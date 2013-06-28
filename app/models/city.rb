class City < ActiveRecord::Base
  attr_accessible :country, :latitude, :longitude, :name, :region
end
