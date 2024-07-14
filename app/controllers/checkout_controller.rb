class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
    prepare_order_details
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.status = 'pending'
    @order.address = current_user.address
    @order.province = current_user.address.province

    if @order.save
      session[:cart] = [] # Clear the cart
      create_stripe_session(@order)
    else
      prepare_order_details
      render :new
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @order = current_user.orders.find_by(stripe_charge_id: @session.id)
    @order.update(status: 'paid') if @order.present?
  end

  def cancel
    # Handle what happens if the payment is cancelled
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
      if @order.order_items.empty?
        @cart_items.each do |item|
          product = Product.find(item["product_id"])
          @order.order_items.build(product: product, quantity: item["quantity"], price: product.price)
        end
      end
      @taxes = calculate_taxes(@order)
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
    order.total_amount = total_amount
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

  def create_stripe_session(order)
    line_items = order.order_items.map do |item|
      {
        price_data: {
          currency: 'usd',
          product_data: {
            name: item.product.name,
          },
          unit_amount: (item.price * 100).to_i,
        },
        quantity: item.quantity,
      }
    end

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url
    )

    order.update(stripe_charge_id: session.id)

    redirect_to session.url, allow_other_host: true
  end

  def checkout_success_url
    "#{root_url}checkout/success"
  end

  def checkout_cancel_url
    "#{root_url}checkout/cancel"
  end
end
