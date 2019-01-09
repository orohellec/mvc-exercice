# frozen_string_literal: true

1.upto(10) do |i|
  Item.create!(
    name: Faker::Commerce.product_name,
    original_price: Faker::Number.decimal(2)
  )
  p "ITEM #{i} : créé"
end
