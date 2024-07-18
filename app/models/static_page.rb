
class StaticPage < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
  
    def should_generate_new_friendly_id?
      title_changed?
    end
  
    validates :title, presence: true
    validates :content, presence: true
    validates :title, length: { minimum: 5, maximum: 100 }
  end
  