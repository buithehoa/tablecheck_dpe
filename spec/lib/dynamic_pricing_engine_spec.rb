require 'rails_helper'

RSpec.describe DynamicPricingEngine do
  describe '.adjust_prices' do
    let!(:product1) { create(:product, name: 'Product 1', price: 100, quantity: 99) }
    let!(:product2) { create(:product, name: 'Product 2', price: 200, quantity: 501) }

    it 'updates the adjusted price of each product' do
      DynamicPricingEngine.adjust_prices

      expect(product1.reload.adjusted_price).to eq(product1.price * (1 + DynamicPricingEngine::INVENTORY_LOW_ADJUSTMENT))
      expect(product2.reload.adjusted_price).to eq(product2.price * (1 + DynamicPricingEngine::INVENTORY_HIGH_ADJUSTMENT))
    end
  end

  describe '.sync_competitor_prices' do
    let!(:product1) { create(:product, name: 'Product 1', price: 100) }
    let!(:product2) { create(:product, name: 'Product 2', price: 200) }
    let(:competitor_product1) { { name: 'Product 1', price: 99 } }
    let(:competitor_product2) { { name: 'Product 2', price: 199 } }

    before do
      allow(CompetitorProductFetcher)
        .to receive(:fetch_products)
        .and_return([competitor_product1, competitor_product2].as_json)
    end

    it 'updates the competitor price of each product' do
      DynamicPricingEngine.sync_competitor_prices

      expect(product1.reload.competitor_price).to eq(99)
      expect(product2.reload.competitor_price).to eq(199)
    end
  end

  describe '.calculate_price' do
    let!(:product) { create(:product, price: 200, quantity: 50) }

    it 'returns the adjusted price based on inventory and demand' do
      adjusted_price = DynamicPricingEngine.calculate_price(product)

      expect(adjusted_price).to eq(product.price * (1 + DynamicPricingEngine::INVENTORY_LOW_ADJUSTMENT))
    end

    it 'returns the adjusted price based on competitor price' do
      product.competitor_price = 199
      adjusted_price = DynamicPricingEngine.calculate_price(product)
      expect(adjusted_price).to eq(199)
    end
  end
end
