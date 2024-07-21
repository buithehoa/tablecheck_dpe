require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:products) }
  end

  describe "factory" do
    it "creates a valid category" do
      expect(build(:category)).to be_valid
    end
  end
end
