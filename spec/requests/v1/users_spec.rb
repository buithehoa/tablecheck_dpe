require 'rails_helper'

RSpec.describe "V1::Users", type: :request do
  describe "GET /index" do
    it "returns a successful response" do
      get v1_users_path
      expect(response).to be_successful
    end

    it "renders the users as JSON" do
      get v1_users_path
      expect(response.body).to eq(User.all.to_json)
    end
  end
end
