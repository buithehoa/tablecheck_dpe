FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    api_token { SecureRandom.urlsafe_base64(24) }
  end
end
