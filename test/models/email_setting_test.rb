require "test_helper"

describe EmailSetting do
  before do
    @email_setting = EmailSetting.new
  end

  it "must be valid" do
    @email_setting.valid?.must_equal true
  end
end
