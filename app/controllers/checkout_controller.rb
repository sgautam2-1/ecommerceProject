# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_address_present, only: [:new, :create]

  def new
    @cart_items = session[:cart] || []
    @address = current_user.address
    @order = current_user.orders.build
    @order.address = @address
    @order.province = @address.province
    @cart_items.each do |item|
      product = Product.find(item["product_id"])
      @order.order_items.build(product: product, quantity: item["quantity"], price: product.price)
    end
    calculate_total_with_taxes
  end

  def create
    @cart_items = session[:cart] || []
    @order = current_user.orders.build(order_params)
    @order.status = 'pending'
    @order.address = current_user.address
    @order.province = current_user.address.province
    calculate_total_with_taxes

    if @order.save
      session[:cart] = [] # Clear the cart
      redirect_to checkout_path(@order), notice: 'Order placed successfully. Please complete payment.'
    else
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
    calculate_total_with_taxes
  end

  def payment
    @order = current_user.orders.find(params[:id])
    @amount = (@order.total_amount * 100).to_i # Amount in cents
  
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Order #{@order.id}",
      currency: 'usd'
    )
  
    @order.update(status: 'paid', stripe_customer_id: customer.id, stripe_charge_id: charge.id)
  
    redirect_to orders_path, notice: 'Payment successful and order placed.'
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to checkout_path(@order)
  end

  private

  def ensure_address_present
    unless current_user.address
      redirect_to new_address_path, alert: 'Please enter your address to continue.'
    end
  end

  def order_params
    params.require(:order).permit(order_items_attributes: [:product_id, :quantity, :price])
  end

  def calculate_total_with_taxes
    subtotal = @order.order_items.sum { |item| item.quantity * item.price }
    gst = subtotal * (@order.province.gst || 0) / 100
    pst = subtotal * (@order.province.pst || 0) / 100
    hst = subtotal * (@order.province.hst || 0) / 100
    qst = subtotal * (@order.province.qst || 0) / 100
    total_taxes = gst + pst + hst + qst
    @taxes = {
      subtotal: subtotal.round(2),
      gst: gst.round(2),
      pst: pst.round(2),
      hst: hst.round(2),
      qst: qst.round(2),
      total_taxes: total_taxes.round(2),
      total_amount: (subtotal + total_taxes).round(2)
    }
    @order.total_amount = @taxes[:total_amount]
  end
end
