# app/models/user.rb
class User < ApplicationRecord
  # Include default Devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, :registerable, :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         # app/models/user.rb

  has_one :address
  accepts_nested_attributes_for :address
  # Other associations and validations

  # Ensure you have the following line if you need password functionality:
  # has_secure_password

  # Optional: Uncomment if you want to customize password validations
  # validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
end
