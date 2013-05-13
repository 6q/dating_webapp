# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  surname                :string(255)
#  screen_name            :string(255)
#  gender                 :string(255)
#  orientation            :string(255)
#  marital_status         :string(255)
#  birth_date             :date
#  postal_code            :string(255)
#  town                   :string(255)
#  country                :string(255)
#  newsletter_optin       :boolean
#  latitude               :float
#  longitude              :float
#  physical_style         :string(255)
#  physical_desc          :string(255)
#  height                 :integer
#  weight                 :integer
#  complexion             :string(255)
#  child                  :string(255)
#  smoke                  :string(255)
#  diet                   :string(255)
#  alcohol                :string(255)
#  religion               :string(255)
#  animals                :string(255)
#  study_level            :string(255)
#  language               :string(255)
#  job                    :string(255)
#  salary                 :string(255)
#  description            :string(255)
#  party                  :text
#  music                  :text
#  cinema                 :text
#  lf_gender              :string(255)
#  lf_orientation         :string(255)
#  lf_marital_status      :string(255)
#  lf_age_between         :string(255)
#  lf_age_to              :string(255)
#  lf_city                :string(255)
#  lf_country             :string(255)
#  lf_postal_code         :string(255)
#  lf_physical_style      :string(255)
#  lf_physical_desc       :string(255)
#  lf_height_between      :integer
#  lf_height_to           :integer
#  lf_weight_between      :integer
#  lf_weight_to           :integer
#  lf_complexion          :string(255)
#  lf_child               :string(255)
#  lf_child_want          :string(255)
#  lf_smoke               :string(255)
#  lf_smoke_tolerance     :string(255)
#  lf_diet                :string(255)
#  lf_alcohol             :string(255)
#  lf_drugs               :string(255)
#  lf_drug_frequency      :string(255)
#  lf_religion            :string(255)
#  lf_religion_opinion    :string(255)
#  lf_animal_like         :string(255)
#  lf_animal_have         :string(255)
#  lf_study_level         :string(255)
#  lf_language            :string(255)
#  lf_job                 :string(255)
#  lf_salary              :string(255)
#  lf_description         :string(255)
#  house                  :string(255)
#  eyes                   :string(255)
#  hair                   :string(255)
#  hair_style             :string(255)
#  citizenship            :string(255)
#  ethnicity              :string(255)
#  language_level         :string(255)
#  wedding_opinion        :string(255)
#  music_genre            :string(255)
#  cinema_frequency       :string(255)
#  cinema_genre           :string(255)
#  like_sport             :string(255)
#  like_read              :string(255)
#  like_cinema            :string(255)
#  like_quiet             :string(255)
#  like_walk              :string(255)
#  like_mountain          :string(255)
#  like_beach             :string(255)
#  like_family            :string(255)
#  like_friends           :string(255)
#  religion_activity      :string(255)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def messages(errors)
    errors.full_messages.join
  end

  test 'performs validations when creating a regular user' do
    u = FactoryGirl.build(:regular_user)
    assert u.valid?, messages(u.errors)
    u.password_confirmation = ""
    refute u.valid?
    u.password = "password"
    u.password_confirmation = "password"
    assert u.valid?, messages(u.errors)
    u.email_confirmation = ""
    refute u.valid?
    u.email_confirmation = u.email
    assert u.valid?, messages(u.errors)
    u.newsletter_optin = false
    assert u.valid?, messages(u.errors)
  end

  test 'performs validations when creating a matchmaker' do
    u = FactoryGirl.build(:matchmaker)
    assert u.valid?, messages(u.errors)
  end

  test 'geocode user' do
    u = FactoryGirl.create(:regular_user, postal_code: '08008', town: 'Barcelona', country: 'Spain')
    u.longitude
    assert_equal Geocoder.coordinates(u.location), [u.latitude, u.longitude]
  end

  test 'matchmaker with recommendations' do
    u = create(:matchmaker_with_recommendations)
    assert u.recommendations.nil?.must_equal false
    assert u.recommendations.count.must_equal 1
    assert u.recommendations[0].creator_id.must_equal u.id
  end

  test 'regular user with recommenders' do
    u = create(:regular_user_with_recommenders)
    assert u.recommenders.nil?.must_equal false
    assert u.recommenders.count.must_equal 1
    assert u.recommenders[0].user_id.must_equal u.id
  end

end
