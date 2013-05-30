require "test_helper"

describe Search do
  before do
    @user = create(:regular_user)
    @search = @user.searches.build(attributes_for(:search))
  end

  it "must be valid" do
    @search.valid?.must_equal true
  end
end
