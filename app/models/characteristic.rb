# == Schema Information
#
# Table name: characteristics
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  creator_id  :integer
#  romantic    :integer          default(3), not null
#  adventurer  :integer          default(3), not null
#  friendly    :integer          default(3), not null
#  familiar    :integer          default(3), not null
#  hardWorking :integer          default(3), not null
#  extroverted :integer          default(3), not null
#  generous    :integer          default(3), not null
#  reserved    :integer          default(3), not null
#  sociable    :integer          default(3), not null
#  quiet       :integer          default(3), not null
#  demanding   :integer          default(3), not null
#  prideful    :integer          default(3), not null
#  solitary    :integer          default(3), not null
#  tenacious   :integer          default(3), not null
#  attentive   :integer          default(3), not null
#  goodHumored :integer          default(3), not null
#  spontaneous :integer          default(3), not null
#  restless    :integer          default(3), not null
#  sensitive   :integer          default(3), not null
#  shy         :integer          default(3), not null
#  possessive  :integer          default(3), not null
#  jealous     :integer          default(3), not null
#  faithful    :integer          default(3), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Characteristic < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  belongs_to :user, class_name: "User", foreign_key: :user_id

  attr_accessible :romantic, :adventurer, :friendly, 
  	:familiar, :hardWorking, :extroverted, :generous, :reserved, :sociable, 
  	:quiet, :demanding, :prideful, :solitary, :tenacious, :attentive, :goodHumored, 
  	:spontaneous, :restless, :sensitive, :shy, :possessive, :jealous, :faithful

  validates :user_id, uniqueness: { scope: :creator_id }
end
