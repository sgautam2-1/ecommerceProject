
class StaticPage < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
  
    def should_generate_new_friendly_id?
      title_changed?
    end
  
    # Example validation, replace with your actual validations
    validates :title, presence: true
  end
  