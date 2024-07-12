

# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province
  validates :line1, :city, :state, :country, :zipcode, :province_id, presence: true
end
