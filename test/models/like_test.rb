require "test_helper"

describe Like do
  before do
    @like = Like.new
  end

  it "must be valid" do
    @like.valid?.must_equal true
  end
end
