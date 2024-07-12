# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :name, :gst, :pst, :hst, :qst, presence: true
end