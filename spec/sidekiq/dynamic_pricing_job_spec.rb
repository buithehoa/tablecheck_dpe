require 'rails_helper'

RSpec.describe DynamicPricingJob, type: :job do
  it 'calls DynamicPricingEngine.adjust_prices' do
    expect(DynamicPricingEngine).to receive(:adjust_prices)
    subject.perform
  end
end
