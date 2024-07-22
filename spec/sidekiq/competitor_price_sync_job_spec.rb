require 'rails_helper'

RSpec.describe CompetitorPriceSyncJob, type: :job do
  it 'calls DynamicPricingEngine.sync_competitor_prices' do
    expect(DynamicPricingEngine).to receive(:sync_competitor_prices)
    subject.perform
  end
end
