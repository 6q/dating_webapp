require 'test_helper'

describe Conversation do
  before do
    @conversation = Conversation.new
  end

  it "should not have an activity" do
    assert_equal nil, @conversation.activity
  end

end
