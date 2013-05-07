require "test_helper"

describe ActivitiesController do
  it "should get new" do
    get :new
    assert_response :success
  end

  it "should get create" do
    get :create
    assert_response :success
  end

  it "should get accept" do
    get :accept
    assert_response :success
  end

  it "should get reject" do
    get :reject
    assert_response :success
  end

end
