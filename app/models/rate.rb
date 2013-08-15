# == Schema Information
#
# Table name: rates
#
#  id          :integer          not null, primary key
#  rater_id    :integer
#  rateable_id :integer
#  stars       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable

  attr_accessible :stars

  validates :rater_id, uniqueness: { scope: :rateable_id }

  def self.average_score_for_user(user)
    where(rateable_id: user.id).average('stars')
  end

  scope :unseen, where(seen: false)
end
