require 'discordrb'

# Initialize the bot
BOT = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_BOT_TOKEN'], prefix: '!'

# Example command
BOT.command :ping do |event|
  event.respond 'Pong!'
end

# List products
BOT.command :products do |event|
  products = Product.limit(10).map { |p| "#{p.name}: #{p.description}" }
  event.respond products.join("\n")
end

# Search products by category
BOT.command :search do |event, category_name|
  category = Category.find_by(name: category_name)
  if category
    products = category.products.map { |p| "#{p.name}: #{p.description}" }
    event.respond products.join("\n")
  else
    event.respond "Category not found!"
  end
end

# Run the bot in a separate thread to not block the Rails server
Thread.new { BOT.run }
