require "test_helper"

describe GeneralSetting do
  before do
    @general_setting = GeneralSetting.new
  end

  it "must be valid" do
    @general_setting.valid?.must_equal true
  end
end
