require "test_helper"

describe Recommendation do

  it "must be valid" do
    recommendation = build(:recommendation)
    recommendation.user_id = 1
    recommendation.creator_id = 2
    recommendation.valid?.must_equal true
  end

  it "must be invalid" do
    recommendation = build(:invalid_recommendation)
    recommendation.valid?.must_equal false
  end

  it "performs validations when creating a recommendation" do
    r = build(:recommendation)
    r.user_id = 1
    r.creator_id = 2
    r.valid?.must_equal true
    r.relationship = ''
    r.valid?.must_equal false
    r.relationship = 1
    r.valid?.must_equal true
    r.description = ''
    r.valid?.must_equal false
    r.description = 'A description'
    r.valid?.must_equal true
    r.user_id = nil
    r.valid?.must_equal false
    r.user_id = 1
    r.valid?.must_equal true
    r.creator_id = nil    
    r.valid?.must_equal false
    r.creator_id = 2
    r.valid?.must_equal true
  end
end
