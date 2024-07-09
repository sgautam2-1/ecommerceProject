# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

# db/seeds.rb

# db/seeds.rb

# db/seeds.rb

require 'uri'  # Ensure URI module is required

# Ensure categories exist before seeding products
electronics_category = Category.find_or_create_by!(name: 'Electronics')
clothing_category = Category.find_or_create_by!(name: 'Clothing')
books_category = Category.find_or_create_by!(name: 'Books')
home_category = Category.find_or_create_by!(name: 'Home')

# Helper method to generate image URL
def generate_image_url(seed)
  "https://picsum.photos/seed/#{URI.encode_www_form_component(seed)}/300/300"
end

# Seed more products across categories with sensible data
50.times do
  product_name = Faker::Commerce.product_name
  image_url = generate_image_url(product_name)

  category = electronics_category
  product_name = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph(sentence_count: 3)
  price = Faker::Commerce.price(range: 50..500.0)
  Product.create!(
    name: product_name,
    description: description,
    price: price,
    image_url: image_url,
    category: category
  )
end

50.times do
  product_name = Faker::Commerce.product_name
  image_url = generate_image_url(product_name)

  category = clothing_category
  product_name = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph(sentence_count: 3)
  price = Faker::Commerce.price(range: 20..200.0)
  Product.create!(
    name: product_name,
    description: description,
    price: price,
    image_url: image_url,
    category: category
  )
end

50.times do
  product_name = Faker::Commerce.product_name
  image_url = generate_image_url(product_name)

  category = books_category
  product_name = Faker::Book.title
  description = Faker::Lorem.paragraph(sentence_count: 3)
  price = Faker::Commerce.price(range: 10..100.0)
  Product.create!(
    name: product_name,
    description: description,
    price: price,
    image_url: image_url,
    category: category
  )
end

50.times do
  product_name = Faker::Commerce.product_name
  image_url = generate_image_url(product_name)

  category = home_category
  product_name = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph(sentence_count: 3)
  price = Faker::Commerce.price(range: 30..300.0)
  Product.create!(
    name: product_name,
    description: description,
    price: price,
    image_url: image_url,
    category: category
  )
end

puts 'Seeding complete!'


puts 'Seeding complete!'