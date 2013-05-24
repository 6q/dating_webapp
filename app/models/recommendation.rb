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
#  confirmed    :boolean          default(FALSE)
#  denied       :boolean          default(FALSE)
#

class Recommendation < ActiveRecord::Base
  attr_accessible :description, :relationship

  # Characteristics can be found through the User model to Characteristic model
  # (using user_id and creator_id)
  # Assuming there can only be one [user_id, creator_id] tuple in Characteristic

  has_many :notifications, :as => :notifiable
  has_one :characteristic, dependent: :destroy
  accepts_nested_attributes_for :characteristic

  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :user, class_name: "User", foreign_key: :user_id

  validates_presence_of :relationship, :description, :user_id, :creator_id
  validates :user_id, uniqueness: { scope: :creator_id }

  after_create do |recommendation|
    begin
      user = User.find(user_id)
      user.notifications.create({ sender_id: creator_id, notifiable_id: recommendation.id, notifiable_type: 'matchmaker' })
    rescue ActiveRecord::RecordNotFound
      # User record was not found
    end
  end
end
