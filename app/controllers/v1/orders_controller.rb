module V1
  class OrdersController < ApplicationController
    include InventoryCheckable

    rescue_from Errors::InventoryShortageError, with: :handle_inventory_shortage_error

    before_action :require_user
    before_action :current_order

    def current
      render json: current_order, serializer: OrderSerializer, status: :ok
    end

    def add
      check_inventory!

      @order_item.quantity += params[:quantity].to_i
      @order_item.save!
      render json: current_order, serializer: OrderSerializer, status: :ok
    end

    def place
      @order = current_user.order.where(status: 'current').first
      @order.update!(status: 'placed')
      render json: { message: "Order placed successfully." }, status: :ok
    end

    private

    def current_order
      @current_order ||= Order.current_order(current_user)
    end

    def handle_inventory_shortage_error
      render json: { message: "Inventory shortage: Cannot add item to order." }, status: :unprocessable_entity
    end
  end
end
