class StaticPage < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end

  validates :title, presence: true
  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "title", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
