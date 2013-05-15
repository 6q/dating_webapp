# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ActiveRecord::Base

  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :user, class_name: "User", foreign_key: :user_id
    
end
