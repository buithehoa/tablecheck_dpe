module InventoryCheckable
  def check_item_inventory!
    @product = Product.find(BSON::ObjectId(params[:product_id]))
    @order_item = current_order.order_items.find_or_create_by(product: @product)

    order_quantity = params[:quantity].to_i + @order_item.quantity
    if @product.quantity < order_quantity
      raise Errors::InventoryShortageError, "Inventory shortage: Cannot add item to order."
    end
  end

  def check_order_inventory!
    @order = Order.current_order(current_user, auto_create: false)
    raise Errors::NoCurrentOrderError if @order.blank?

    @order.order_items.each do |item|
      product = Product.find(item.product_id)
      if item.quantity > product.quantity
        raise Errors::InventoryShortageError, "Inventory shortage: Cannot place order."
      end
    end
  end
end
