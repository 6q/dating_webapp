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

end
