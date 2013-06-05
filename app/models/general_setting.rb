# == Schema Information
#
# Table name: general_settings
#
#  id                           :integer          not null, primary key
#  user_id                      :integer
#  no_email_online              :boolean          default(TRUE)
#  profile_visit                :boolean          default(TRUE)
#  receive_message              :boolean
#  like                         :boolean
#  star_rating                  :boolean
#  celestino_recommendation     :boolean
#  newsletter                   :boolean
#  user_suggestions             :boolean
#  new_users_nearby             :boolean
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  show_online                  :boolean          default(TRUE)
#  allow_chat                   :boolean
#  show_only_nearby             :boolean
#  show_only_matching_profiles  :boolean
#  show_only_people_who_like_me :boolean
#  show_only_buena_pareja       :boolean
#  show_only_pm                 :boolean
#  show_only_rated_me           :boolean
#  anonymous_browsing           :boolean          default(FALSE)
#

class GeneralSetting < ActiveRecord::Base
  attr_accessible :celestino_recommendation, :like, :new_users_nearby,
                  :newsletter, :no_email_online, :profile_visit,
                  :receive_message, :star_rating, :user_id, :user_suggestions,
                  :show_online, :allow_chat, :show_only_nearby,
                  :show_only_matching_profiles, :show_only_people_who_like_me,
                  :show_only_buena_pareja, :show_only_pm, :show_only_rated_me

  attr_accessible :celestino_recommendation, :like, :new_users_nearby,
                  :newsletter, :no_email_online, :profile_visit,
                  :receive_message, :star_rating, :user_id, :user_suggestions,
                  :show_online, :allow_chat, :show_only_nearby,
                  :show_only_matching_profiles, :show_only_people_who_like_me,
                  :show_only_buena_pareja, :show_only_pm, :show_only_rated_me,
                  :anonymous_browsing, :as => :premium_user

  belongs_to :user
end
