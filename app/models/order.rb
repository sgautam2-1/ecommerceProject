# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  belongs_to :address
  has_many :order_items, dependent: :destroy

  before_save :update_total

  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def update_total
    self.total_amount = order_items.sum('quantity * price')
  end
end
