# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_numericality_of(:discount_percentage).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
    end

    describe 'associations' do
      it { is_expected.to have_many(:categories).through(:category_item_connections) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount (price = 100, discount = 20)' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context 'when the item has a discount (price = 60, discount = 30)' do
      let(:item) { build(:item_with_discount, original_price: 60.00, discount_percentage: 30) }

      it { expect(item.price).to eq(42.00) }
    end

    context 'when the item has a discount (price = 54.5176, discount = 30)' do
      let(:item) { build(:item_with_discount, original_price: 54.5176, discount_percentage: 30) }

      it { expect(item.price).to eq(38.16232) }
    end

    context 'when the item do not have discount (price = 53)' do
      let(:item) { build(:item_without_discount, original_price: 53.00) }

      it { expect(item.price).to eq(53.00) }
    end

    context 'when the item do not have discount (price = 73.56)' do
      let(:item) { build(:item_without_discount, original_price: 73.56) }

      it { expect(item.price).to eq(73.56) }
    end

    context 'when the average price is calculated' do
      Item.delete_all
      Item.create!(name: "test", original_price: 100.00, discount_percentage: 20, has_discount: true)
      Item.create!(name: "test2", original_price: 60.00, discount_percentage: 30, has_discount: true)
      Item.create!(name: "test3", original_price: 53.00)
      it { expect(Item.average_price.round(2)).to eq(58.33) }
    end
  end
end
