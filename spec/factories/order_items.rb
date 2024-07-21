FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    order { create(:order) }
    product { create(:product) }
  end
end
