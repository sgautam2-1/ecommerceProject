class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :address, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, class_name: 'CartItem'

  accepts_nested_attributes_for :address
end
