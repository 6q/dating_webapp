# == Schema Information
#
# Table name: searches
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  years_lteq       :integer
#  years_gteq       :integer
#  city_eq          :string(255)
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
#  name             :string(255)
#

class Search < ActiveRecord::Base
  attr_accessible :afinity_eq, :complexion_eq, :children_in, :description_cont,
                  :distance, :height_gteq, :height_lteq, :online, :name,
                  :pictures_main_eq, :smoker_in,
                  :sort, :city_eq, :years_gteq, :years_lteq, :updated_at_gteq

  belongs_to :user

  def search_path

    Rails.application.routes.url_helpers.users_path(:q => {
      :years_start_lteq => self.years_lteq,
      :years_end_gteq => self.years_gteq,
      :name_or_surname_or_screen_name_or_description_cont => self.description_cont,
      :pictures_main_not_null => self.pictures_main_eq,
      :s => self.sort,
      :updated_at_gteq => updated_at_gteq,
      :smoker_in => self.smoker_in,
      :children_in => self.children_in,
      :height_lteq => self.height_lteq,
      :height_gteq => self.height_gteq,
      :afinity_eq => self.afinity_eq,
      :complexion_eq => self.complexion_eq
   },
    :distance => self.distance,
    :city => self.city_eq
  )
  end
end
