class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Integer, default: 0
  field :competitor_price, type: Integer, default: nil
  field :adjusted_price, type: Integer, default: nil
  field :quantity, type: Integer, default: 0

  belongs_to :category

  validates :name, presence: true
  validates :name, uniqueness: true

  def recent_purchased_quantity
    OrderItem.where.in(
      order_id: Order.placed_recently.pluck(:_id),
      product_id: BSON::ObjectId(self._id)).sum(:quantity)
  end

  def recent_added_quantity
    OrderItem.where.in(
      order_id: Order.updated_recently.pluck(:_id),
      product_id: BSON::ObjectId(self._id)).sum(:quantity)
  end
end
