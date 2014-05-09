# == Schema Information
#
# Table name: user_mailings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  sent_user_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserMailing < ActiveRecord::Base
  attr_accessible :user_id, :sent_user_id

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :sent_user, class_name: 'User', foreign_key: 'sent_user_id'

  validates :user_id, uniqueness: { scope: :sent_user_id }
end
