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
    u = FactoryGirl.create(:regular_user, postal_code: '08008', city: 'Barcelona', country: 'Spain')
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

  it 'must have a user_blocks collection' do
    u = create(:regular_user_with_blocks)
    u.must_respond_to :user_blocks
    u.user_blocks.class.must_equal Array
    u.user_blocks.size.must_be :>=, 1
    u.user_blocks[0].class.must_equal UserBlock
  end

  it 'must have a user_hides collection' do
    u = create(:regular_user_with_hides)
    u.must_respond_to :user_hides
    u.user_hides.class.must_equal Array
    u.user_hides.size.must_be :>=, 1
    u.user_hides[0].class.must_equal UserHide
  end

  it 'must have a ratings_given collection' do
    u = create(:regular_user_with_ratings)
    u.must_respond_to :ratings_given
    u.ratings_given.class.must_equal Array
    u.ratings_given.size.must_be :>=, 1
    u.ratings_given[0].class.must_equal Rate
  end

  it 'must have a searches collection' do
    u = create(:regular_user_with_searches)
    u.must_respond_to :searches
    u.searches.class.must_equal Array
    u.searches.size.must_be :>=, 1
    u.searches[0].class.must_equal Search
  end

  # Class method tests
  it 'must have a correct location' do
    u = create(:regular_user, postal_code: '08009', city: 'Barcelona', country: 'Spain')
    u.location.must_equal '08009, Barcelona, Spain'
  end

  it 'must have a correct calculated age' do
    u = create(:regular_user, birth_date: 25.years.ago)
    u.age.must_equal 25
  end

  it 'full name should be correct' do
    u = create(:regular_user, name: 'Philip', surname: 'De Smedt')
    u.full_name.must_equal 'Philip De Smedt'
  end

  it 'must return the confirmed recommendations' do
    @user = create(:regular_user_optin)
    @creator = create(:regular_user_optin)
    recommendation = @creator.recommendations.build(attributes_for(:recommendation))
    recommendation.user_id = @user.id
    recommendation.confirmed = true
    recommendation.save

    @user.confirmed_recommenders.class.must_equal ActiveRecord::Relation
    @user.confirmed_recommenders.length.must_be :>=, 1
    @user.confirmed_recommenders[0].class.must_equal Recommendation
    @user.confirmed_recommenders[0].confirmed.must_equal true
    @user.confirmed_recommenders[0].denied.must_equal false
  end

  it 'must returns the unconfirmed recommendations' do
    @user = create(:regular_user_optin)
    @creator = create(:regular_user_optin)
    recommendation = @creator.recommendations.build(attributes_for(:recommendation))
    recommendation.user_id = @user.id
    recommendation.save

    @user.confirmed_recommenders.length.must_be :<=, 0
    @user.unconfirmed_recommenders.class.must_equal ActiveRecord::Relation
    @user.unconfirmed_recommenders.length.must_be :>=, 1

    @user.unconfirmed_recommenders[0].class.must_equal Recommendation
    @user.unconfirmed_recommenders[0].confirmed.must_equal false
    @user.unconfirmed_recommenders[0].denied.must_equal false
  end

  it 'must have a matchmaker notification' do
    # TODO
    # Not unit-testable atm? Code in controller
  end

  it 'must have a message notification' do
    # TODO
    # Not unit-testable atm?
  end

  it 'must visit the user\'s profile' do
    @user = create(:regular_user_optin)
    @visitor = create(:regular_user_optin)
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
    @user = create(:regular_user_optin)
    @visitor = create(:regular_user_optin)
    @visitor.visited(@user)
    time = @user.user_visits[0].visited_at
    @visitor.visited(@user)
    @user.user_visits[0].visited_at.must_be :>=, time
    
    @user.visitors.length.must_equal 1
  end

  it 'must have a visit notification' do
    @user = create(:regular_user_optin)
    @visitor = create(:regular_user_optin)
    @visitor.visited(@user)

    @user.notifications.class.must_equal Array
    @user.notifications.length.must_be :>=, 1
    @user.notifications[0].class.must_equal CelloveNotification
    @user.notifications[0].notifiable_type.must_equal "visit"
    @user.notifications[0].sender_id.must_equal @visitor.id
    @user.notifications[0].receiver_id.must_equal @user.id
  end

  it 'must like the other user' do
    @user = create(:regular_user)
    @liked_user = create(:regular_user)
    @user.like(@liked_user)

    @liked_user.likers.class.must_equal Array
    @liked_user.likers.length.must_be :>=, 1
    @liked_user.likers[0].class.must_equal Like
    @liked_user.likers[0].user_id.must_equal @liked_user.id
    @liked_user.likers[0].creator_id.must_equal @user.id

    @user.likes.class.must_equal Array
    @user.likes.length.must_be :>=, 1
    @user.likes[0].class.must_equal Like
    @user.likes[0].user_id.must_equal @liked_user.id
    @user.likes[0].creator_id.must_equal @user.id
  end

  it 'must have a like notification' do
    @user = create(:regular_user)
    @liked_user = create(:regular_user)
    @user.like(@liked_user)

    @liked_user.notifications.class.must_equal Array
    @liked_user.notifications.length.must_be :>=, 1
    @liked_user.notifications[0].class.must_equal CelloveNotification
    @liked_user.notifications[0].notifiable_type.must_equal "like"
    @liked_user.notifications[0].sender_id.must_equal @user.id
    @liked_user.notifications[0].receiver_id.must_equal @liked_user.id
  end

  it 'must rate the user with 4 stars' do
    @user = create(:regular_user_optin)
    @rated_user = create(:regular_user_optin)
    @user.rate(4, @rated_user)

    @user.ratings_given.class.must_equal Array
    @user.ratings_given.length.must_be :>=, 1
    @user.ratings_given[0].class.must_equal Rate
    @user.ratings_given[0].stars.must_equal 4.0
    @user.rating(@rated_user.id).must_equal 4.0
  end

  it 'must have raters' do
    @user = create(:regular_user_optin)
    @rated_user = create(:regular_user_optin)
    @user.rate(4, @rated_user)

    @rated_user.raters.class.must_equal Array
    @rated_user.raters.length.must_be :>=, 1
    @rated_user.raters[0].class.must_equal User
    @rated_user.raters[0].id.must_equal @user.id
  end

  it 'must return the nice couples' do
    @user = create(:regular_user_optin)
    @rated_user = create(:regular_user_optin)
    @user.rate(4, @rated_user)
    @rated_user.rate(5, @user)

    User.nice_couple(@user).class.must_equal ActiveRecord::Relation
    User.nice_couple(@user).length.must_be :>=, 1
    User.nice_couple(@user)[0].class.must_equal User
    User.nice_couple(@user)[0].id.must_equal @rated_user.id
  end

  it 'must have a nice couple notification' do
    @user = create(:regular_user_optin)
    @rated_user = create(:regular_user_optin)
    @user.rate(4, @rated_user)
    @rated_user.rate(5, @user)

    @user.notifications.class.must_equal Array
    @user.notifications.length.must_be :>=, 1
    @user.notifications[0].class.must_equal CelloveNotification
    @user.notifications[0].notifiable_type.must_equal "couple"
    @user.notifications[0].sender_id.must_equal @rated_user.id
    @user.notifications[0].receiver_id.must_equal @user.id

    @rated_user.notifications.class.must_equal Array
    @rated_user.notifications.length.must_be :>=, 1
    @rated_user.notifications[0].class.must_equal CelloveNotification
    @rated_user.notifications[0].notifiable_type.must_equal "couple"
    @rated_user.notifications[0].sender_id.must_equal @user.id
    @rated_user.notifications[0].receiver_id.must_equal @rated_user.id
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
