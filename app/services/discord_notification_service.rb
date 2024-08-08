# app/services/discord_notification_service.rb
class DiscordNotificationService
  def initialize
    @bot = DISCORD_BOT
  end

  def notify_new_product(product)
    channel_id = "1261419266935361637" # Your actual channel ID
    message = "New Product Added: **#{product.name}** - $#{'%.2f' % product.price}\n#{product.description}"
    @bot.send_message(channel_id, message)
  end
end
