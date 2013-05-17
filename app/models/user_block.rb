# == Schema Information
#
# Table name: user_blocks
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  blocked_user_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserBlock < ActiveRecord::Base
  # No quiero que me vea más
  # user -> user_block(user_id: user.id, blocked_user_id: X.id)
  attr_accessible :user_id, :blocked_user_id

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :blocked_user, class_name: 'User', foreign_key: 'blocked_user_id'

  validates :user_id, uniqueness: { scope: :blocked_user_id }
end
