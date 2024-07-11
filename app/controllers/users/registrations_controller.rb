# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /users/sign_up
  def new
    super
    @user.build_address unless @user.address # Ensure a new Address object is associated with the user
    @address = @user.address || Address.new # Initialize @address with user's existing address or a new Address object
  end

  # POST /users
  def create
    super
  end

  private

  # Permit additional parameters (address_attributes) for sign-up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation,
                                                      address_attributes: [:street_address, :city, :province_id, :postal_code]])
  end
end
