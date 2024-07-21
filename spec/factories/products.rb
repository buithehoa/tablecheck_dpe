FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    price { 10 }
    quantity { 5 }
    category { create(:category) }
  end
end
