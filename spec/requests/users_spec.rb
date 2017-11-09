require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user1) { create(:user, nickname: "User1") }
  let(:user2) { create(:user, nickname: "User2") }
  let(:user3) { create(:user, nickname: "User3", last_online_at: 2.days.ago) }
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get "/users"
      expect(response).to have_http_status(200)
    end
  end
end
