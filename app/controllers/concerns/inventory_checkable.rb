module InventoryCheckable
  def check_inventory!
    @product = Product.find(BSON::ObjectId(params[:product_id]))
    @order_item = current_order.order_items.find_or_create_by(product: @product)

    if @product.quantity < (params[:quantity].to_i + @order_item.quantity)
      raise Errors::InventoryShortageError
    end
  end
end
