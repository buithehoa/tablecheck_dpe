class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :status, type: String, default: 'current'

  belongs_to :user
  has_many :order_items

  module Status
    CURRENT = 'current'
    PLACED = 'placed'
  end

  def place!
    raise Errors:OrderAlreadyPlacedError if self.status == Status::PLACED

    self.order_items.each do |item|
      product = item.product
      product.quantity -= item.quantity
      product.save!
    end

    self.update!(status: Status::PLACED)
  end

  def self.current_order(user, auto_create: true)
    order = user.orders.where(status: Status::CURRENT).first

    Rails.logger.info "auto_create: #{auto_create}"
    if auto_create
      order ||= create!(user: user, status: Status::CURRENT)
    end

    order
  end
end
