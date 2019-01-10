# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_item_connections, dependent: :destroy, inverse_of: :category
  has_many :items, through: :category_item_connections

  validates :name, allow_nil: false, uniqueness: true
end
