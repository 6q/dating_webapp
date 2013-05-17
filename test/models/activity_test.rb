require "test_helper"

describe Activity do
  before do
    @activity = FactoryGirl.create(:activity)
  end

  it "must be valid" do
    @activity.valid?.must_equal true
  end

  it "should accept an activity" do
    @activity = FactoryGirl.create(:activity)
    @activity.accept!
    @activity.accepted?.must_equal true
  end

  it "should reject an activity" do
    @activity.reject!
    @activity.rejected?.must_equal true
  end
  
  it "should not have status" do
    @activity.status.must_be_nil
    @activity.accepted?.must_be_nil
    @activity.rejected?.must_be_nil
  end
end
