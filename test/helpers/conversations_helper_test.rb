require "test_helper"

describe ConversationsHelper do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:regular_user)
    @recipient = FactoryGirl.create(:regular_user)
  end

  it "should get the other party" do
    @receipt = @user.send_message(@recipient, 'Body', 'Subject')
    def current_user
      @user
    end
    sender_or_recipient(@receipt.conversation).must_equal(@recipient)
  end
end
