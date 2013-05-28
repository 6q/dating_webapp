require "test_helper"

describe Invitation do
  before do
    @invitation = Invitation.new
  end

  it "must be valid" do
    @invitation.valid?.must_equal true
  end
end
