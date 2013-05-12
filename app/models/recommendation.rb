# == Schema Information
#
# Table name: recommendations
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  creator_id   :integer
#  relationship :integer
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Recommendation < ActiveRecord::Base
  attr_accessible :description, :relationship

  # Characteristics can be found through the User model to Characteristic model
  # (using user_id and creator_id)
  # Assuming there can only be one [user_id, creator_id] tuple in Characteristic

  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :user, class_name: "User", foreign_key: :user_id

  validates_presence_of :relationship, :description, :user_id, :creator_id
end
