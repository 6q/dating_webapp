require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def messages(errors)
    errors.full_messages.join
  end

  test 'performs validations when creating a regular user' do
    u = FactoryGirl.build(:regular_user)
    u.must_be_instance_of User
    u.valid?.must_equal true
    u.password_confirmation = ""
    u.valid?.must_equal false
    u.password = "password"
    u.password_confirmation = "password"
    u.valid?.must_equal true
    u.email_confirmation = ""
    u.valid?.must_equal false
    u.email_confirmation = u.email
    u.valid?.must_equal true
    u.newsletter_optin = false
    u.valid?.must_equal true
  end

  test 'performs validations when creating a matchmaker' do
    u = FactoryGirl.build(:matchmaker)
    u.valid?.must_equal true
  end

  test 'geocode user' do
    u = FactoryGirl.create(:regular_user, postal_code: '08008', town: 'Barcelona', country: 'Spain')
    [u.latitude, u.longitude].must_equal Geocoder.coordinates(u.location)
  end

  test 'matchmaker with recommendations' do
    u = create(:matchmaker_with_recommendations)
    u.recommendations.nil?.must_equal false
    u.recommendations.count.must_equal 1
    u.recommendations[0].creator_id.must_equal u.id
  end

  test 'regular user with recommenders' do
    u = create(:regular_user_with_recommenders)
    u.recommenders.nil?.must_equal false
    u.recommenders.count.must_equal 1
    u.recommenders[0].user_id.must_equal u.id
  end

  test 'invited user' do
    u = build(:invited_user)
    u.must_be_instance_of User
    u.surname.must_equal nil
    u.email.wont_equal nil
  end

end
