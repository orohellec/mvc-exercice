# frozen_string_literal: true

1.upto(5) do |i|
  Category.create!(
    name: Faker::Commerce.department,
    description: "description #{i}"
  )
  p "CATEGORIE #{i} : créé"
end

1.upto(10) do |i|
  Item.create!(
    name: Faker::Commerce.product_name,
    original_price: Faker::Number.decimal(2)
  )
  p "ITEM #{i} : créé"
  CategoryItemConnection.create!(
    category_id: rand(1..5),
    item_id: i
  )
end
