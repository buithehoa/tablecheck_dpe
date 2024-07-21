class DynamicPricingEngine
  class << self
    def adjust_prices
      # It's safe to use all as Mongo driver already batches all records
      # https://stackoverflow.com/a/8611674/87972
      Product.all.each do |product|
        product.update!(adjusted_price: calculate_price(product))
      end
    end

    def calculate_price(product)
      Rails.logger.info "[INFO] product = #{product.inspect}"
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
  end
end
