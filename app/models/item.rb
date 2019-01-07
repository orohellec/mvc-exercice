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
    return average
  end
end
