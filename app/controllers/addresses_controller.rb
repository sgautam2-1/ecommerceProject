class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = Address.new
  end

  def create
    @address = current_user.build_address(address_params)
    
    if Province.exists?(params[:address][:province_id]) && @address.save
      redirect_to new_checkout_path, notice: 'Address saved successfully.'
    else
      flash[:alert] = 'Error saving address. Please ensure all fields are correctly filled.'
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:line1, :line2, :city, :state, :country, :zipcode, :province_id)
  end
end
