class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ensure_address_present, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name,
                                             { address_attributes: %i[line1 line2 city state
                                                                      country zipcode province_id] }])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:name,
                                             { address_attributes: %i[line1 line2 city state
                                                                      country zipcode province_id] }])
  end

  private

  def ensure_address_present
    if user_signed_in? && current_user.address.nil? && request.path != new_address_path && request.path != addresses_path
      redirect_to new_address_path, alert: "Please enter your address to continue."
    end
  end
end
