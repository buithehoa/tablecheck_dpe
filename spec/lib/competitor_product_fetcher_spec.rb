require 'rails_helper'

RSpec.describe CompetitorProductFetcher do
  describe '.fetch_products' do
    let(:api_response) { '{"products": [{"id": 1, "name": "Product 1", "price": 10.99}]}'.to_json }
    let(:api_url) { "https://sinatra-pricing-api.fly.dev/prices?api_key=demo123" }
    let(:inventory) do
      [
        { name: "Rubik's Cube Shirt", category: "Footwear", price: 1873, quantity: 284 },
        { name: "Care Bears Sweater", category: "Clothing", price: 2933, quantity: 230 }
      ]
    end
    let(:api_response) { inventory.to_json }

    it "returns an array of products" do
      stub_request(:get, api_url).to_return(status: 200, body: api_response, headers: {})

      products = CompetitorProductFetcher.fetch_products
      expect(products).to be_a(Array)
      expect(products.first).to be_a(Hash)
      expect(products.first['name']).to eq("Rubik's Cube Shirt")
      expect(products.first['category']).to eq('Footwear')
      expect(products.first['price']).to eq(1873)
      expect(products.first['quantity']).to eq(284)
    end

    it 'logs an error if the API request fails' do
      stub_request(:get, api_url).to_return(body: '', status: 500)
      expect(Rails.logger).to receive(:error).with(/API request failed/)

      CompetitorProductFetcher.fetch_products
    end

    it 'logs an error if the JSON response is invalid' do
      stub_request(:get, api_url).to_return(body: 'invalid json', status: 200)
      expect(Rails.logger).to receive(:error).with(/Invalid JSON response/)
      
      CompetitorProductFetcher.fetch_products
    end
  end
end
