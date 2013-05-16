require "test_helper"

describe UserBlock do
  before do
    @user_block = UserBlock.new
  end

  it "must be valid" do
    @user_block.valid?.must_equal true
  end
end
