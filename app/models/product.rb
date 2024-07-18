class Product < ApplicationRecord
  belongs_to :category

  after_create :notify_discord

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "price", "category_id", "image_url", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  private

  def notify_discord
    DiscordNotificationService.new.notify_new_product(self)
  end
end
