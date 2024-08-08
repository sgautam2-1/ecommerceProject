# config/initializers/active_admin.rb

# This part should be at the top of the file to ensure the Quill editor input is loaded correctly
require 'quill_editor_input'

ActiveAdmin.setup do |config|
  # Your existing configuration...
  config.site_title = "EchoTreasures"

  config.authentication_method = :authenticate_admin_user!
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long

  # Register Quill editor JavaScript and stylesheet
  config.register_javascript 'https://cdn.quilljs.com/1.3.6/quill.js'
  config.register_stylesheet 'https://cdn.quilljs.com/1.3.6/quill.snow.css'

  # Other configurations...
end
