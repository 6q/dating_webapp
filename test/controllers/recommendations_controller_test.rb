require "test_helper"

describe RecommendationsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an authenticated user" do
    it "POST #create should redirect to the user sign in path" do
      assert_difference 'Recommendation.count', 0 do
        post :create, recommendation: attributes_for(:recommendation)
      end
      assert_response 302
      assert_redirected_to new_user_session_path
    end
  end
  
  describe "as a matchmaker" do
    before(:each) do
      @user = create(:regular_user)
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

    it "POST #create with invalid user email should (re-)render the be_matchmaker page" do
      assert_difference 'Recommendation.count', 0 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user.name, email: nil },
          characteristic: attributes_for(:characteristic)
        }
      end

      @matchmaker.recommendations.length.must_equal 0
      @user.recommenders.length.must_equal 0

      assert_response 200
      assert_template("users/be_matchmaker")
    end
  end

  describe "as a regular user" do
    before(:each) do
      @user = create(:regular_user)
      @matchmaker = create(:matchmaker)
      @characteristic = create(:characteristic)
      sign_in @user
    end

    it "POST #create with valid data should create a new recommendation" do
      assert_difference 'Recommendation.count', 1 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @matchmaker.name, email: @matchmaker.email },
          characteristic: attributes_for(:characteristic)
        }
      end
      assigns(:recommendation).must_be_instance_of(Recommendation)
      assigns(:recommendation).user_id.must_equal @matchmaker.id
      assigns(:recommendation).creator_id.must_equal @user.id

      @matchmaker.recommenders.length.must_equal 1
      @user.recommendations.length.must_equal 1

      assigns(:characteristic).creator_id.must_equal @user.id
      assigns(:characteristic).user_id.must_equal @matchmaker.id

      assert_response 302
      assert_redirected_to be_matchmaker_path
    end

    it "POST #create with invalid user email should (re-)render the be_matchmaker page" do
      assert_difference 'Recommendation.count', 0 do
        post :create, {
          recommendation: attributes_for(:recommendation),
          user: { name: @user.name, email: nil },
          characteristic: attributes_for(:characteristic)
        }
      end

      @matchmaker.recommenders.length.must_equal 0
      @user.recommendations.length.must_equal 0

      assert_response 200
      assert_template("users/be_matchmaker")
    end
  end
end
