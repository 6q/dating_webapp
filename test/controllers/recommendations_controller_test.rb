require "test_helper"

describe RecommendationsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an unauthenticated user" do
    it "POST #create should redirect to the user sign in path" do
      assert_difference 'Recommendation.count', 0 do
        post :create, recommendation: attributes_for(:recommendation)
      end
      assert_response 302
      assert_redirected_to root_path
    end

    it "GET #accept should redirect to the user sign in path" do
      get :accept, recommendation_id: 1

      assert_response 302
      assert_redirected_to root_path
    end

    it "GET #deny should redirect to the user sign in path" do
      get :deny, recommendation_id: 1

      assert_response 302
      assert_redirected_to root_path
    end
  end
  
  describe "as a matchmaker" do
    before(:each) do
      @user = create(:regular_user_optin)
      @matchmaker = create(:matchmaker)
      @characteristic = create(:characteristic)
      sign_in @matchmaker
    end

    it "POST #create with valid data should create a new recommendation" do
      assert_difference 'Recommendation.count', 1 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user.name, email: @user.email },
          characteristic: attributes_for(:characteristic)
        }
      end
      assigns(:recommendation).must_be_instance_of(Recommendation)
      assigns(:recommendation).creator_id.must_equal @matchmaker.id
      assigns(:recommendation).user_id.must_equal @user.id

      @matchmaker.recommendations.length.must_equal 1
      @user.recommenders.length.must_equal 1

      assigns(:characteristic).user_id.must_equal @user.id
      assigns(:characteristic).creator_id.must_equal @matchmaker.id

      assert_response 302
      assert_redirected_to be_matchmaker_path
    end

    it "POST #create with invalid user email should redirect to the profile page" do
      assert_difference 'Recommendation.count', 0 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user.name, email: nil },
          characteristic: attributes_for(:characteristic)
        }
      end

      @matchmaker.recommendations.length.must_equal 0
      @user.recommenders.length.must_equal 0

      assert_response 302
      assert_redirected_to be_matchmaker_path
    end
  end

  describe "as a regular user" do
    before(:each) do
      @user = create(:regular_user_optin)
      @user_two = create(:regular_user_optin)
      @characteristic = create(:characteristic)
      sign_in @user
    end

    # shared_examples_for 'create recommendation' do
    # end

    it "POST #create with valid data should create a new recommendation" do
      #it_behaves_like 'create recommendation'
      assert_difference 'Recommendation.count', 1 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user_two.name, email: @user_two.email },
          characteristic: attributes_for(:characteristic)
        }
      end
      assigns(:recommendation).must_be_instance_of(Recommendation)
      assigns(:recommendation).user_id.must_equal @user_two.id
      assigns(:recommendation).creator_id.must_equal @user.id
      assigns(:recommendation).characteristic.recommendation_id.must_equal assigns(:recommendation).id

      @user_two.recommenders.length.must_equal 1
      @user.recommendations.length.must_equal 1

      assigns(:characteristic).creator_id.must_equal @user.id
      assigns(:characteristic).user_id.must_equal @user_two.id

      assert_response 302
      assert_redirected_to be_matchmaker_path
    end

    it "POST #create with invalid user email should redirect the profile page" do
      assert_difference 'Recommendation.count', 0 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user.name, email: nil },
          characteristic: attributes_for(:characteristic)
        }
      end

      @user_two.recommenders.length.must_equal 0
      @user.recommendations.length.must_equal 0

      assert_response 302
      assert_redirected_to be_matchmaker_path
    end

    # it "GET #accept should accept the recommendation" do
    #   sign_in @matchmaker
    #   @recommendation = @matchmaker.recommendations.build(attributes_for(:recommendation))
    #   @recommendation.user_id = @user.id
    #   @recommendation.save

    #   @recommendation.must_be_instance_of(Recommendation)
    #   @recommendation.user_id.must_equal @user.id
    #   @recommendation.creator_id.must_equal @matchmaker.id

    #   sign_in @user
    #   get :accept, recommendation_id: @recommendation.id
    #   @recommendation.confirmed.must_equal true 
    # end
  end
end
