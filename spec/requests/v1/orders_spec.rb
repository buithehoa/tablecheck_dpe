require 'rails_helper'

RSpec.describe V1::OrdersController, type: :request do
  describe "GET /current" do
    context "with a current order" do
      let(:user) { create(:user) }
      let!(:order) { create(:order, user: user) }

      it "returns a successful response with the current order" do
        get current_v1_orders_path, params: { api_token: user.api_token }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).symbolize_keys).to eq(OrderSerializer.new(order).as_json)
      end
    end

    context "without a current order" do
      let(:user) { create(:user) }

      it "returns a successful response" do
        get current_v1_orders_path, params: { api_token: user.api_token }

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /add" do
    context "with valid params" do
      let(:user) { create(:user) }
      let!(:order) { create(:order, user: user) }
      let(:product) { create(:product) }
      let(:request_params) { { api_token: user.api_token, product_id: product.id } }

      it "increases the quantity of the order item and returns a successful response" do
        put add_v1_orders_path, params: request_params

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).symbolize_keys)
          .to eq(OrderSerializer.new(order.reload).as_json)
      end
    end
  end
end
