FactoryBot.define do
  factory :order do
    status { 'current' }

    user { create(:user) }
  end
end
