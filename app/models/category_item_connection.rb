# frozen_string_literal: true

class CategoryItemConnection < ApplicationRecord
  belongs_to :category, inverse_of: :category_item_connections
  belongs_to :item, inverse_of: :category_item_connections
end
