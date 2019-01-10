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

class Category < ApplicationRecord
  has_many :category_item_connections, dependent: :destroy, inverse_of: :category
  has_many :items, through: :category_item_connections

  validates :name, allow_nil: false, uniqueness: true
end
