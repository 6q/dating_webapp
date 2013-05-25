require "test_helper"

describe UserHide do
  before do
    @user_hide = UserHide.new
  end

  it "must be valid" do
    @user_hide.valid?.must_equal true
  end
end
