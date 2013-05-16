require "test_helper"

describe Like do
  before do
    @like = Like.new
    @like.user_id = 1
    @like.creator_id = 2
  end

  it "must be valid" do
    @like.valid?.must_equal true
  end

end
