require "test_helper"

describe RecommendationsController do
  describe "guest access" do
    describe "POST #create" do
      it "requires login" do
        #post :create, id: create(:recommendation), recommendation: attributes_for(:recommendation)
        #expect(response).to redirect_to root_url
      end
    end
  end

  describe "user access" do
    describe 'POST #create' do
      context "with valid attributes" do
        it "creates and saves the new recommendation in the database"
        it "redirects to the be_matchmaker path"
      end

      context "with invalid attributes" do
        it "does not save the new recommendation in the database"
        it "re-renders the be_matchmaker template"
      end
    end
  end
end
