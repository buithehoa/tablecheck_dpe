class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Integer, default: 0
  field :quantity, type: Integer, default: 0

  belongs_to :category

  validates :name, presence: true
  validates :name, uniqueness: true
end
