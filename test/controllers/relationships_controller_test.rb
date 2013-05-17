require "test_helper"

describe RelationshipsController do
  include Devise::TestHelpers

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "as an unauthenticated user" do
    before(:each) do
      @user = create(:regular_user_optin)
    end

    it "should redirect to the the new user session path (POST #like)" do
      post :like, user_id: @user.id
      assert_response 302
      assert_redirected_to new_user_session_path
    end

    it "should redirect to the the new user session path (POST #block_hide)" do
      post :block_hide, user_id: @user.id, user_block: { blocked_user_id: 1 }, user_hide: { hidden_user_id: 1 } 
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

    it "should redirect to the celestino become user path (POST #block_hide)" do
      post :block_hide, user_id: @liked_user.id, user_block: { blocked_user_id: 1 }, user_hide: { hidden_user_id: 1 } 
      assert_response 302
      assert_redirected_to matchmaker_become_user_path
    end
  end

  describe "as a regular user" do
    before(:each) do
      @user = create(:regular_user)
      @interacted_user = create(:regular_user_optin)
      sign_in @user
    end

    it "should create a new like in the database (POST #like)" do
      assert_difference 'Like.count', 1 do
        post :like, user_id: @interacted_user.id
      end
      @interacted_user.likers.length.must_equal 1
      @user.likes.length.must_equal 1
    end

    it "should block the interacted user" do
      assert_difference 'UserBlock.count', 1 do
        post :block_hide, user_id: @interacted_user.id, user_block: { blocked_user_id: 1 }, user_hide: { hidden_user_id: 0 }
      end
      @user.user_blocks.length.must_equal 1
      @user.user_blocks[0].class.must_equal UserBlock
      @user.user_blocks[0].blocked_user_id.must_equal @interacted_user.id
      @user.user_blocks[0].user_id.must_equal @user.id

      @user.user_hides.length.must_equal 0
    end

    it "should hide the interacted user" do
      assert_difference 'UserHide.count', 1 do
        post :block_hide, user_id: @interacted_user.id, user_block: { blocked_user_id: 0 }, user_hide: { hidden_user_id: 1 }
      end
      @user.user_hides.length.must_equal 1
      @user.user_hides[0].class.must_equal UserHide
      @user.user_hides[0].hidden_user_id.must_equal @interacted_user.id
      @user.user_hides[0].user_id.must_equal @user.id

      @user.user_blocks.length.must_equal 0
    end

    describe "as a blocked or hidden interacted user" do
      before :each do
        post :block_hide, user_id: @interacted_user.id, user_block: { blocked_user_id: 1 }, user_hide: { hidden_user_id: 1 }
      end

      it "should show a hidden user again" do
        @user.user_hides.length.must_equal 1
        @user.user_hides[0].class.must_equal UserHide
        @user.user_hides[0].hidden_user_id.must_equal @interacted_user.id

        assert_difference 'UserHide.count', -1 do
          post :block_hide, user_id: @interacted_user.id, user_block: { blocked_user_id: 1 }, user_hide: { hidden_user_id: 0 }
        end

        @user.reload
        @user.user_hides.length.must_equal 0
        @user.user_blocks.length.must_equal 1
        @user.user_blocks[0].class.must_equal UserBlock
        @user.user_blocks[0].blocked_user_id.must_equal @interacted_user.id
      end

      it "should unblock a blocked user" do
        @user.user_blocks.length.must_equal 1
        @user.user_blocks[0].class.must_equal UserBlock
        @user.user_blocks[0].blocked_user_id.must_equal @interacted_user.id

        assert_difference 'UserBlock.count', -1 do
          post :block_hide, user_id: @interacted_user.id, user_block: { blocked_user_id: 0 }, user_hide: { hidden_user_id: 1 }
        end

        @user.reload
        @user.user_blocks.length.must_equal 0
      end
    end
  end
end
