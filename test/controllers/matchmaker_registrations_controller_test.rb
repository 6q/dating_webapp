require 'test_helper'

describe MatchmakerRegistrationsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an unauthenticated user" do

    it "POST #create should create a new matchmaker" do
      assert_difference 'User.count', 1 do
        post :create, matchmaker: attributes_for(:matchmaker)
      end
      assigns(:user).must_be_instance_of(User)
      assigns(:user).has_role?(:matchmaker).must_equal true

      assert_response 302
      assert_redirected_to @controller.profile_path
    end

  end

end
