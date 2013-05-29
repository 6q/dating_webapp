# == Schema Information
#
# Table name: email_settings
#
#  id                       :integer          not null, primary key
#  user_id                  :integer
#  no_email_online          :boolean
#  profile_visit            :boolean
#  receive_message          :boolean
#  like                     :boolean
#  star_rating              :boolean
#  celestino_recommendation :boolean
#  newsletter               :boolean
#  user_suggestions         :boolean
#  new_users_nearby         :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class EmailSetting < ActiveRecord::Base
  attr_accessible :celestino_recommendation, :like, :new_users_nearby,
                  :newsletter, :no_email_online, :profile_visit,
                  :receive_message, :star_rating, :user_id, :user_suggestions

  belongs_to :user
end
