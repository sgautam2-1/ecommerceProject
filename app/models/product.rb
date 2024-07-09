# app/models/product.rb

class Product < ApplicationRecord
    belongs_to :category
  
    def self.ransackable_attributes(auth_object = nil)
      ["name", "description", "price", "category_id", "image_url", "created_at", "updated_at"]
    end
  
    def self.ransackable_associations(auth_object = nil)
      ["category"]
    end
  end
  