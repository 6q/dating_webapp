require 'test_helper'

describe Conversation do
  before do
    @conversation = Conversation.new
  end

  it "should not have an activity" do
    @conversation.activity.must_equal nil
  end

end
