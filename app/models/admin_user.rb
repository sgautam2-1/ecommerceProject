class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable
end

class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Define which attributes can be searched by Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end
end

ActiveAdmin.setup do |config|
  config.register_javascript 'https://cdn.quilljs.com/1.3.6/quill.js'
  config.register_stylesheet 'https://cdn.quilljs.com/1.3.6/quill.snow.css'
end