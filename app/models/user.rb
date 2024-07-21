# app/models/user.rb
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :username, type: String
  field :api_token, type: String

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :api_token, presence: true
  validates :api_token, uniqueness: true

  has_many :orders
end
