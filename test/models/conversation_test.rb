require 'test_helper'

describe Conversation do
  before do
    @conversation = Conversation.new
  end

  it "should not have an activity" do
    @conversation.activity.must_equal nil
  end

  it "should have an activity" do
    @conversation.activity = FactoryGirl.build(:activity)
    @conversation.save
    @conversation.activity.must_be_instance_of Activity
  end

  it "should accept an activity" do
    @activity = FactoryGirl.create(:activity)
    @activity.accept!
    @activity.accepted?.must_equal true
  end

  it "should reject an activity" do
    @activity = FactoryGirl.create(:activity)
    @activity.reject!
    @activity.rejected?.must_equal true
  end
end
