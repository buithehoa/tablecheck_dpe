module V1
  class OrdersController < ApplicationController
    include InventoryCheckable

    rescue_from Errors::InventoryShortageError,
                Errors::NoCurrentOrderError,
                Errors::OrderAlreadyPlacedError,
                with: :handle_error

    before_action :require_user
    before_action :current_order, only: [:add, :current]

    def current
      render json: current_order, serializer: OrderSerializer, status: :ok
    end

    def add
      check_item_inventory!

      @order_item.quantity += params[:quantity].to_i
      @order_item.save!

      render json: current_order, serializer: OrderSerializer, status: :ok
    end

    def place
      check_order_inventory!

      @order.place!

      render json: { message: "Order placed successfully." }, status: :ok
    end

    private

    def current_order
      @current_order ||= Order.current_order(current_user)
    end

    def handle_error(exception)
      render json: { message: exception.message }, status: :unprocessable_entity
    end
  end
end
