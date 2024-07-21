require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to(:order) }
  it { is_expected.to belong_to(:product) }

  it { is_expected.to validate_numericality_of(:quantity).greater_than_or_equal_to(0) }

  it 'has a valid factory' do
    expect(build(:order_item)).to be_valid
  end
end
