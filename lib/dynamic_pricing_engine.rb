class DynamicPricingEngine
  INVENTORY_HIGH_THRESHOLD = 500    # Quantity above which inventory is considered high
  INVENTORY_LOW_THRESHOLD = 100     # Quantity below which inventory is considered low
  INVENTORY_HIGH_ADJUSTMENT = -0.1  # -10%
  INVENTORY_LOW_ADJUSTMENT = 0.05   # 5%

  DEMAND_THRESHOLD = 100    # Quantity above which demand is considered high
  DEMAND_ADJUSTMENT = 0.05  # 5%

  class << self
    def adjust_prices
      # It's safe to use all as Mongo driver already batches all records
      # https://stackoverflow.com/a/8611674/87972
      Product.all.each do |product|
        product.update!(adjusted_price: calculate_price(product))
      end
    end

    def sync_competitor_prices
      competitor_products = CompetitorProductFetcher.fetch_products

      competitor_products.each do |competitor_product|
        product = Product.find_by(name: competitor_product['name'])

        if product.present?
          product.update! competitor_price: competitor_product['price'].to_i
        end
      end
    end

    # private

    def calculate_price(product)
      adjusted_price = product.price

      adjusted_price *= (1 + inventory_adjustment(product.quantity))
      adjusted_price *= (1 + demand_adjustment(product))
      adjusted_price = competitor_adjustment(adjusted_price, product.competitor_price)

      adjusted_price.to_i
    end

    def inventory_adjustment(quantity)
      return INVENTORY_HIGH_ADJUSTMENT if quantity > INVENTORY_HIGH_THRESHOLD
      return INVENTORY_LOW_ADJUSTMENT if quantity < INVENTORY_LOW_THRESHOLD
      return 0
    end

    def demand_adjustment(product)
      # Increase price for high demand
      recent_demand = product.recent_purchased_quantity + product.recent_added_quantity

      return DEMAND_ADJUSTMENT if recent_demand > DEMAND_THRESHOLD
      return 0
    end

    def competitor_adjustment(adjusted_price, competitor_price)
      return adjusted_price if competitor_price.nil?

      # Strategy: Match lowest competitor price
      return competitor_price if adjusted_price > competitor_price
      return adjusted_price
    end
  end
end
