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
                  :pictures_main_eq, :postal_code_cont, :smoker_in,
                  :sort, :city_eq, :years_gteq, :years_lteq

  belongs_to :user

  def search_path
    if self.online?
      updated_at_gteq = 2.minutes.ago
    end
    Rails.application.routes.url_helpers.users_path(:q => {
      :years_lteq => self.years_lteq,
      :years_gteq => self.years_gteq,
      :city_eq => self.city_eq,
      :postal_code_cont => self.postal_code_cont,
      :description_cont => self.description_cont,
      :pictures_main_eq => self.pictures_main_eq,
      :s => self.sort,
      :updated_at_gteq => updated_at_gteq,
      :smoker_in => self.smoker_in,
      :children_in => self.children_in,
      :height_lteq => self.height_lteq,
      :height_gteq => self.height_gteq,
      :afinity_eq => self.afinity_eq,
      :complexion_eq => self.complexion_eq
    }, :distance => self.distance)
  end
end
