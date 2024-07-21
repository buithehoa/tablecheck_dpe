class OrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  field :quantity, type: Integer, default: 0

  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
