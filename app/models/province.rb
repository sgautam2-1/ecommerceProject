class Province < ApplicationRecord
  has_many :addresses
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    ["name", "gst", "pst", "hst", "qst", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["addresses", "orders"]
  end
end
