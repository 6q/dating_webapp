require "test_helper"

describe ConversationsController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:regular_user)
    sign_in @user

    @receiver = FactoryGirl.create(:regular_user)
    @receipt = @user.send_message(@receiver, "Body", "A subject")
  end

  it "should update a conversation" do
    put :update, id: @receipt.conversation.id, :message => { body: "This is a reply" }
    assert_redirected_to conversation_path(assigns(:conversation))
    assigns(:receipt).message.body.must_equal('This is a reply')
  end

  it "must accept the proposed activity" do
    @receipt.conversation.activity = FactoryGirl.build(:activity)
    put :update, id: @receipt.conversation.id, accept_activity: true, :message => { body: "This is a reply" }

    assigns(:receipt).conversation.activity.accepted?.must_equal true
  end
end
