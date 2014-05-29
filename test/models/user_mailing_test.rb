require "test_helper"

describe UserMailing do
  before do
    @user_mailing = UserMailing.new
  end

  it "must be valid" do
    @user_mailing.valid?.must_equal true
  end
end
