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
#  name                :string
#

class Item < ApplicationRecord
  has_many :category_item_connections, dependent: :destroy, inverse_of: :item
  has_many :categories, through: :category_item_connections

  validates :name, presence: true, uniqueness: true
  validates :discount_percentage, numericality: { only_integer: true,
                                                  less_than_or_equal_to: 100,
                                                  greater_than_or_equal_to: 0 }

  def price
    if has_discount == true
      (original_price * (100 - discount_percentage) / 100)
    else
      original_price
    end
  end

  def self.average_price
    total = 0
    all.find_each do |item|
      total += item.price
    end
    (total / all.size)
  end

  def update_promo(discount)
    if discount.to_i.positive? && discount.to_i <= 100
      update(discount_percentage: discount, has_discount: true)
    else # negative number and other type than integer are managed by validates in model
      update(discount_percentage: discount, has_discount: false)
    end
  end
end
