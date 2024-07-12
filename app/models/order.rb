class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province
  belongs_to :address
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  before_save :update_total

  validates :status, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
    order_items.sum { |item| item.quantity * item.price }
  end

  def gst
    subtotal * (province.gst || 0) / 100
  end

  def pst
    subtotal * (province.pst || 0) / 100
  end

  def hst
    subtotal * (province.hst || 0) / 100
  end

  def qst
    subtotal * (province.qst || 0) / 100
  end

  def total_taxes
    gst + pst + hst + qst
  end

  def total_amount
    subtotal + total_taxes
  end

  private

  def update_total
    self.total_amount = subtotal + total_taxes
  end
end
