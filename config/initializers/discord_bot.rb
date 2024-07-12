# config/initializers/discord_bot.rb
require 'discordrb'

DISCORD_BOT = Discordrb::Bot.new token: 'MTI2MTQxMzMzNTgwNzY5MjgwMA.GGiVTZ.r0poLvd1hIx-94JnDqBsnmod8Oe6UTrtHX9MtM'

DISCORD_BOT.run(true)
