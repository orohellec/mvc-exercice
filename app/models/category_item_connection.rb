# frozen_string_literal: true

# == Schema Information
#
# Table name: category_item_connections
#
#  id          :bigint(8)        not null, primary key
#  category_id :bigint(8)
#  item_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CategoryItemConnection < ApplicationRecord
  belongs_to :category, inverse_of: :category_item_connections
  belongs_to :item, inverse_of: :category_item_connections
end
