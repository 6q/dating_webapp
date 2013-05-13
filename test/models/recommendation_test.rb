require "test_helper"

describe Recommendation do

  it "must be valid" do
    recommendation = create(:recommendation)
    recommendation.valid?.must_equal true
  end

  it "must be invalid" do
    recommendation = build(:invalid_recommendation)
    recommendation.valid?.must_equal false
  end

  it "performs validations when creating a recommendation" do
    r = create(:recommendation)
    assert r.valid?.must_equal true
    r.relationship = ''
    refute r.valid?
    r.relationship = 1
    assert r.valid?.must_equal true
    r.description = ''
    refute r.valid?
    r.description = 'A description'
    assert r.valid?.must_equal true
    r.user_id = nil
    refute r.valid?
    r.user_id = 1
    assert r.valid?.must_equal true
    r.creator_id = nil    
    refute r.valid?
    r.creator_id = 2
    assert r.valid?.must_equal true
  end
end
