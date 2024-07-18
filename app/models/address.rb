class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  def self.ransackable_attributes(auth_object = nil)
    ["city", "country", "created_at", "id", "line1", "line2", "province_id", "state", "street", "updated_at", "user_id", "zipcode"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
