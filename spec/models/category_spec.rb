require 'rails_helper'

RSpec.describe Category, type: :model do
  
  describe "associations" do
    it { is_expected.to have_many(:product_categories).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:product_categories) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  it_has_behavior_of "like searchable concern", :category, :name
  it_behaves_like "paginatable concern", :category
end
