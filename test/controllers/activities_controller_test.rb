require "test_helper"

describe ActivitiesController do
  include Devise::TestHelpers

  before do
    @user = FactoryGirl.create(:regular_user)
    sign_in @user
  end
end
