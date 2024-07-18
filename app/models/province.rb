class Province < ApplicationRecord
  has_many :addresses
  has_many :orders

  validates :name, presence: true
  validates :gst, :pst, :hst, :qst, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  

  def self.ransackable_attributes(auth_object = nil)
    ["name", "gst", "pst", "hst", "qst", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["addresses", "orders"]
  end
end
