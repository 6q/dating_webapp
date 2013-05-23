# == Schema Information
#
# Table name: user_hides
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  hidden_user_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class UserHide < ActiveRecord::Base
  # No quiero verla más
  # user -> user_hide(user_id: user.id, hidden_user_id: X.id)
  attr_accessible :user_id, :hidden_user_id

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :hidden_user, class_name: 'User', foreign_key: 'hidden_user_id'

  validates :user_id, uniqueness: { scope: :hidden_user_id }
end
