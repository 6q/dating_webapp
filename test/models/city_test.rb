require "test_helper"

describe City do
  before do
    @city = City.new
  end

  it "must be valid" do
    @city.valid?.must_equal true
  end
end
