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

class Item < ApplicationRecord
  has_many :category_item_connections, inverse_of: :item
  has_many :categories, through: :category_item_connections

  def price
    if self.has_discount
      return (self.original_price * (100 - self.discount_percentage) / 100)
    else
      return self.original_price
    end
  end

  def self.average_price
    total = 0
    all_items = self.all
    all_items.each do |item|
      total += item.price
    end
    average = (total / all_items.size)
  end

  def update_promo(discount)
    if discount.to_i > 0 && discount.to_i <= 100
      self.update(discount_percentage: discount, has_discount: true)
    elsif discount.to_i == 0
      self.update(discount_percentage: discount, has_discount: false)
    else
      puts "between 0 to 100 please"
    end
  end
end
