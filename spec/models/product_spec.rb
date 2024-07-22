require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  describe '#recent_purchased_quantity' do
    let(:product) { create(:product) }
    let(:order) { create(:order, :placed) }
    let!(:order_item) { create(:order_item, order: order, product: product, quantity: 2) }

    it 'eturns the sum of quantities of recent orders' do
      expect(product.recent_purchased_quantity).to eq(2)
    end
  end

  describe '#recent_added_quantity' do
    let(:product) { create(:product) }
    let(:order) { create(:order) }
    let!(:order_item) { create(:order_item, order: order, product: product, quantity: 3) }

    it 'eturns the sum of quantities of recent orders' do
      expect(product.recent_added_quantity).to eq(3)
    end
  end
end
