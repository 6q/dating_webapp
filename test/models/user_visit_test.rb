require "test_helper"

describe UserVisit do
  before do
    @user_visit = UserVisit.new
    @user_visit.user_id = 1
    @user_visit.visitor_id = 2
    @user_visit.visited_at = Time.now
  end

  it "must be valid" do
    @user_visit.valid?.must_equal true
  end

end
