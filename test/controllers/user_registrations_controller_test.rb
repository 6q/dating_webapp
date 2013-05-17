require "test_helper"

describe UserRegistrationsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an unauthenticated user" do
    it "POST #create should create a new user" do
      assert_difference 'User.count', 1 do
        post :create, user: attributes_for(:regular_user)
      end
      assigns(:user).must_be_instance_of(User)
      assigns(:user).has_role?(:regular_user).must_equal true
      assigns(:user).my_characteristics.user_id.must_equal assigns(:user).id
      assigns(:user).my_characteristics.creator_id.must_equal assigns(:user).id

      assert_response 302
      assert_redirected_to @controller.after_sign_up_path_for(assigns(:user))
    end

    it "PUT #update should redirect to the root path" do
      @user = create(:regular_user)
      put :update, id: @user, user: attributes_for(:regular_user, name: 'John', surname: 'Doe')
      assert_response 302
      assert_redirected_to new_user_session_path
    end
  end

  describe "as an unauthenticated invited user" do
    before :each do
      @user = build(:invited_user, invitation_code: 'invite123')
      @user.save(validate: false)
    end

    it "POST #create should create a new user" do
      @user.has_role?(:invited_user).must_equal true

      assert_difference 'User.count', 0 do
        post :create, user: attributes_for(:regular_user, email: @user.email, invitation_code: 'invite123')
      end

      @user.reload
      @user.must_be_instance_of(User)
      @user.has_role?(:regular_user).must_equal true
      @user.has_role?(:invited_user).must_equal false
      @user.my_characteristics.user_id.must_equal assigns(:user).id
      @user.my_characteristics.creator_id.must_equal assigns(:user).id

      assert_response 302
      assert_redirected_to @controller.after_sign_up_path_for(assigns(:user))
    end

    it "PUT #update should redirect to the root path" do
      @user = create(:regular_user)
      put :update, id: @user, user: attributes_for(:regular_user, name: 'John', surname: 'Doe')
      assert_response 302
      assert_redirected_to new_user_session_path
    end
  end

  describe "as a regular user" do
    before(:each) do
      @user = create(:regular_user)
      sign_in @user
    end

    it "POST create should not create a new user and redirect to the root path" do
      assert_difference 'User.count', 0 do
        post :create, user: attributes_for(:regular_user)
      end
      assert_response 302
      assert_redirected_to root_path
    end

    it "PUT #update should redirect the regular user to the root path" do
      put :update, id: @user, user: attributes_for(:regular_user, name: 'John', surname: 'Doe')
      assert_response 302
      assert_redirected_to root_path      
    end
  end

  describe "as a matchmaker" do
    before(:each) do
      @user = create(:matchmaker)
      sign_in @user
    end

    it "POST create should not create a new user and redirect to the root path" do
      assert_difference 'User.count', 0 do
        post :create, user: attributes_for(:regular_user)
      end
      assert_response 302
      assert_redirected_to root_path
    end

    it "PUT #update with valid attributes should update the matchmaker account to a regular user account" do
      put :update, id: @user, user: attributes_for(:matchmaker,
        town: 'Barcelona', country: 'Spain', postal_code: '08009',
        marital_status: 'single', orientation: 'heterosexual', gender: 'male',
        birth_date: Date.today)

      @user.reload
      @user.postal_code.must_equal '08009'
      @user.town.must_equal 'Barcelona'
      @user.country.must_equal 'Spain'
      @user.marital_status.must_equal 'single'
      @user.orientation.must_equal 'heterosexual'
      @user.gender.must_equal 'male'

      @user.has_role?(:regular_user).must_equal true
      @user.has_role?(:matchmaker).must_equal false

      assert_response 302
      assert_redirected_to @controller.after_sign_up_path_for(assigns(:user))
    end

    it "PUT #update with invalid attributes should not update the matchmaker account to a regular user account" do
      put :update, id: @user, user: attributes_for(:matchmaker, gender: 'male', country: nil, postal_code: nil)

      @user.reload
      @user.gender.wont_equal 'male'

      @user.has_role?(:regular_user).must_equal false
      @user.has_role?(:matchmaker).must_equal true

      assert_response(:success)
      # Not sure which path helper this should be :\
      #assert_template(edit_user_registration_path)
    end
  end
end
