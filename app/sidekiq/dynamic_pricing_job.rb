class DynamicPricingJob
  include Sidekiq::Job

  def perform(*args)
    DynamicPricingEngine.adjust_prices
  end
end
