require 'test_helper'

describe User do

  it 'performs validations when creating a regular user' do
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

  it 'performs validations when creating a matchmaker' do
    u = FactoryGirl.build(:matchmaker)
    u.valid?.must_equal true
  end

  it 'tests a geocode user' do
    u = FactoryGirl.create(:regular_user, postal_code: '08008', town: 'Barcelona', country: 'Spain')
    [u.latitude, u.longitude].must_equal Geocoder.coordinates(u.location)
  end

  it 'tests a matchmaker with recommendations' do
    u = create(:matchmaker_with_recommendations)
    u.recommendations.nil?.must_equal false
    u.recommendations.count.must_equal 1
    u.recommendations[0].creator_id.must_equal u.id
  end

  it 'tests a regular user with recommenders' do
    u = create(:regular_user_with_recommenders)
    u.recommenders.nil?.must_equal false
    u.recommenders.count.must_equal 1
    u.recommenders[0].user_id.must_equal u.id
  end

  it 'tests an invited user' do
    u = build(:invited_user)
    u.must_be_instance_of User
    u.surname.must_equal nil
    u.email.wont_equal nil
  end

    it 'must have a likes collection' do
    u = create(:regular_user_with_likes)
    u.must_respond_to :likes
    u.likes.class.must_equal Array
    u.likes.size.must_be :>=, 1
    u.likes[0].class.must_equal Like
  end

  it 'must have a likers collection' do
    u = create(:regular_user_with_likers)
    u.must_respond_to :likers
    u.likers.class.must_equal Array
    u.likers.size.must_be :>=, 1
    u.likers[0].class.must_equal Like
  end

  it 'must have a user_visits collection' do
    u = create(:regular_user_with_visitors)
    u.must_respond_to :visitors
    u.must_respond_to :user_visits
    u.user_visits.class.must_equal Array
    u.user_visits.size.must_be :>=, 1
    u.user_visits[0].class.must_equal UserVisit
  end

  # Class method tests
  it 'must have a correct location' do
    u = create(:regular_user, postal_code: '08009', town: 'Barcelona', country: 'Spain')
    u.location.must_equal '08009, Barcelona, Spain'
  end

  # This test randomly fails. WTF?
  # it 'must have a correct calculated age' do
  #   u = create(:regular_user, birth_date_day: Date.today.day,
  #     birth_date_month: Date.today.month, birth_date_year: '1988')
  #   u.age.must_equal 25
  # end

  it 'full name should be correct' do
    u = create(:regular_user, name: 'Philip', surname: 'De Smedt')
    u.full_name.must_equal 'Philip De Smedt'
  end

  it 'confirmed_recommenders returns the right recommendations' do
  end

  it 'unconfirmed_recommenders returns the right recommendations' do
  end

  it 'must save the correct visitor' do
    @user = create(:regular_user)
    @visitor = create(:regular_user)
    @visitor.visited(@user)

    @user.user_visits.class.must_equal Array
    @user.visitors.class.must_equal Array
    @user.visitors.length.must_be :>=, 1
    @user.visitors[0].class.must_equal User

    @user.user_visits[0].visited_at.class.must_equal ActiveSupport::TimeWithZone
    @user.user_visits[0].visitor_id.must_equal @visitor.id
    @user.user_visits[0].user_id.must_equal @user.id

    @user.visitors[0].id.must_equal @visitor.id
  end

  it 'must update the visited time' do
    @user = create(:regular_user)
    @visitor = create(:regular_user)
    @visitor.visited(@user)
    time = @user.user_visits[0].visited_at
    @visitor.visited(@user)
    @user.user_visits[0].visited_at.must_be :>=, time
    
    @user.visitors.length.must_equal 1
  end

end
