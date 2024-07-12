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
  product_name = Faker::Book.title  # Use Faker::Book.title for books
  image_url = generate_image_url(product_name)

  category = books_category
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

puts 'Products seeded successfully!'

# Provinces seeding
provinces = [
  { name: 'Alberta', gst: 5.0, pst: 0.0, qst: 0.0, hst: 0.0 },
  { name: 'British Columbia', gst: 5.0, pst: 7.0, qst: 0.0, hst: 0.0 },
  { name: 'Manitoba', gst: 5.0, pst: 7.0, qst: 0.0, hst: 0.0 },
  { name: 'New Brunswick', gst: 0.0, pst: 0.0, qst: 0.0, hst: 15.0 },
  { name: 'Newfoundland and Labrador', gst: 0.0, pst: 0.0, qst: 0.0, hst: 15.0 },
  { name: 'Northwest Territories', gst: 5.0, pst: 0.0, qst: 0.0, hst: 0.0 },
  { name: 'Nova Scotia', gst: 0.0, pst: 0.0, qst: 0.0, hst: 15.0 },
  { name: 'Nunavut', gst: 5.0, pst: 0.0, qst: 0.0, hst: 0.0 },
  { name: 'Ontario', gst: 0.0, pst: 0.0, qst: 0.0, hst: 13.0 },
  { name: 'Prince Edward Island', gst: 0.0, pst: 0.0, qst: 0.0, hst: 15.0 },
  { name: 'Quebec', gst: 5.0, pst: 0.0, qst: 9.975, hst: 0.0 },
  { name: 'Saskatchewan', gst: 5.0, pst: 6.0, qst: 0.0, hst: 0.0 },
  { name: 'Yukon', gst: 5.0, pst: 0.0, qst: 0.0, hst: 0.0 }
]

provinces.each do |province|
  # Find or create the province by name and update its attributes
  Province.find_or_create_by!(name: province[:name]).update!(
    gst: province[:gst],
    pst: province[:pst],
    qst: province[:qst],
    hst: province[:hst]
  )
end

puts "Provinces seeded successfully."
