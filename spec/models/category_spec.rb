# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Model instantiation' do
    subject(:new_category) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
    end

    describe 'validations' do
      Category.delete_all
      Category.create!(name: "lola", description: "du bon chocolat")
      it { is_expected.to validate_uniqueness_of(:name) }
    end

    describe 'associations' do
      it { is_expected.to have_many(:items).through(:category_item_connections) }
    end
  end
end
