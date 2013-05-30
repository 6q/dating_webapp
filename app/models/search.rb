# == Schema Information
#
# Table name: searches
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  years_lteq       :integer
#  years_gteq       :integer
#  town_eq          :string(255)
#  postal_code_cont :string(255)
#  description_cont :string(255)
#  pictures_main_eq :boolean
#  distance         :integer
#  sort             :string(255)
#  online           :boolean
#  smoker_in        :string(255)
#  children_in      :string(255)
#  height_lteq      :integer
#  height_gteq      :integer
#  afinity_eq       :integer
#  complexion_eq    :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Search < ActiveRecord::Base
  attr_accessible :afinity_eq, :complexion_eq, :children_in, :description_cont,
                  :distance, :height_gteq, :height_lteq, :online,
                  :pictures_main_eq, :postal_code_cont, :smoker_in,
                  :sort, :town_eq, :user_id, :years_gteq, :years_lteq

  belongs_to :user
end
