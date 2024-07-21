class CompetitorPricePollJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info "[INFO] CompetitorPricePollJob #{Time.current.to_i}"
  end
end
