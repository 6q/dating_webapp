require 'test_helper'

describe User do

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

  # Class method tests
  test 'location should be correct' do
    u = create(:regular_user, postal_code: '08009', town: 'Barcelona', country: 'Spain')
    u.location.must_equal '08009, Barcelona, Spain'
  end

  test 'age should be correct' do
    u = create(:regular_user, birth_date_day: Date.today.day,
      birth_date_month: Date.today.month, birth_date_year: '1988')
    u.age.must_equal 25
  end

  test 'full name should be correct' do
    u = create(:regular_user, name: 'Philip', surname: 'De Smedt')
    u.full_name.must_equal 'Philip De Smedt'
  end

  test 'confirmed_recommenders returns the right recommendations' do
  end

  test 'unconfirmed_recommenders returns the right recommendations' do
  end

  test 'should find users by age range' do
    create(:regular_user, birth_date: Date.today - 18.years)
    create(:regular_user, birth_date: Date.today - 21.years)
    create(:regular_user, birth_date: Date.today - 22.years)

    puts User.search(years_lteq: 18, years_gteq: 23).result.count.must_equal 3
  end

  test 'should find online users' do
    offline_user = create(:regular_user, updated_at: Date.today.yesterday)
    online_user = create(:regular_user)
    online_user.touch

    User.search(updated_at_gteq: 5.minutes.ago).result.count.must_equal 1
    offline_user.online?.must_equal false
    online_user.online?.must_equal true
  end

  test 'should find smoker users' do
    u = create(:regular_user, smoke: :smoker)

    User.search(smoke_in: ['smoker']).result.first.must_equal u
  end

  test 'should find users with children' do
    u = create(:regular_user, child: :have_children_want_more)

    User.search(children_in: ['have_children_want_more']).result.first.must_equal u
    User.search(children_in: ['children']).result.first.must_be_nil
  end
end
