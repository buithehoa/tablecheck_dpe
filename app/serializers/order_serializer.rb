class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status

  has_many :order_items

  def order_items
    object.order_items.map do |order_item|
      {
        product: order_item.product.name,
        quantity: order_item.quantity
      }
    end
  end
end
