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

  def self.current_order(user)
    order = user.orders.where(status: Status::CURRENT).first
    order ||= create!(user: user, status: Status::CURRENT)

    order
  end
end
