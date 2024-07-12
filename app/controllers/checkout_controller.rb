# app/controllers/checkout_controller.rb
class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    prepare_order_details
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = 'pending'
    prepare_order_details  # Ensure order details are prepared before saving

    Rails.logger.debug("Order Details before save: #{@order.attributes}")
    Rails.logger.debug("Order Items before save: #{@order.order_items.map(&:attributes)}")

    if @order.save
      session[:cart] = [] # Clear the cart
      redirect_to orders_path, notice: 'Order placed successfully.'
    else
      Rails.logger.debug("Order save errors: #{@order.errors.full_messages}")
      prepare_order_details
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(order_items_attributes: [:product_id, :quantity, :price])
  end

  def prepare_order_details
    if current_user.address && current_user.address.province
      @order.address = current_user.address
      @order.province = current_user.address.province
      @cart_items = session[:cart] || []

      # Clear existing order items if any (optional, depends on your logic)
      @order.order_items.clear if @order.new_record?

      @cart_items.each do |item|
        product = Product.find(item["product_id"])
        @order.order_items.build(product: product, quantity: item["quantity"], price: product.price)
      end
      @taxes = calculate_taxes(@order)
      @order.total_amount = @taxes[:total_amount]  # Ensure the order's total amount is updated
    else
      redirect_to new_address_path, alert: 'Please update your address with a valid province.'
    end
  end

  def calculate_taxes(order)
    subtotal = order.order_items.sum { |item| item.quantity * item.price }
    province = order.province
    gst = subtotal * province.gst / 100
    pst = subtotal * province.pst / 100
    hst = subtotal * province.hst / 100
    qst = subtotal * province.qst / 100
    total_taxes = gst + pst + hst + qst
    total_amount = subtotal + total_taxes
    {
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      qst: qst,
      total_taxes: total_taxes,
      total_amount: total_amount
    }
  end
end
