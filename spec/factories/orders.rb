FactoryBot.define do
  factory :order do
    status { 'current' }

    user { create(:user) }

    trait :placed do
      status { 'placed' }
    end
  end
end
