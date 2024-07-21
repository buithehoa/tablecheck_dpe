class CompetitorPriceSyncJob
  include Sidekiq::Job

  def perform(*args)
    DynamicPricingEngine.sync_competitor_prices
  end
end
