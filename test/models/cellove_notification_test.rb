require "test_helper"

describe CelloveNotification do
  before do
    @cellove_notification = CelloveNotification.new
  end

  it "must be valid" do
    @cellove_notification.valid?.must_equal true
  end
end
