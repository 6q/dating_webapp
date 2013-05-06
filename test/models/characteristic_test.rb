require "test_helper"

describe Characteristic do
  before do
    @characteristic = Characteristic.new
  end

  it "must be valid" do
    @characteristic.valid?.must_equal true
  end
end
