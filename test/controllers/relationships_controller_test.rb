require "test_helper"

describe RelationshipsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an unauthenticated user" do
    before(:each) do
      @liked_user = create(:regular_user_optin)
    end

    it "should redirect to the the new user session path (POST #like)" do
      post :like, user_id: @liked_user.id
      assert_response 302
      assert_redirected_to new_user_session_path
    end
  end

  describe "as a matchmaker" do
    before(:each) do
      @user = create(:matchmaker)
      @liked_user = create(:regular_user_optin)

      sign_in @user
    end

    it "should redirect to the celestino become user path (POST #like)" do
      post :like, user_id: @liked_user.id
      assert_response 302
      assert_redirected_to matchmaker_become_user_path
    end
  end

  describe "as a regular user" do
    before(:each) do
      @user = create(:regular_user)
      @liked_user = create(:regular_user_optin)
      sign_in @user
    end

    it "should create a new like in the database (POST #like)" do
      assert_difference 'Like.count', 1 do
        post :like, user_id: @liked_user.id
      end
      @liked_user.likers.length.must_equal 1
      @user.likes.length.must_equal 1
    end
  end
end
