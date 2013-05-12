require "test_helper"

describe Recommendation do
  before do
    @recommendation = Recommendation.new
  end

  it "must be valid" do
    @recommendation.valid?.must_equal true
  end
end
