# == Schema Information
#
# Table name: user_visits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  visitor_id :integer
#  visited_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  seen       :boolean          default(FALSE)
#  invisible  :boolean          default(FALSE)
#

class UserVisit < ActiveRecord::Base
  attr_accessible :visited_at, :seen, :invisible

  belongs_to :user
  belongs_to :visitor, :foreign_key => 'visitor_id', :class_name => 'User'
  has_many :notifications, :as => :notifiable

  validates :user_id, uniqueness: { scope: [:visitor_id, :invisible] }
  validates_presence_of :user_id, :visitor_id, :visited_at

  scope :unseen, where(seen: false)
end
