class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(order_items: :product)
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:product)
    @taxes = calculate_taxes(@order)
  end

  private

  def calculate_taxes(order)
    subtotal = order.order_items.sum { |item| item.quantity * item.price }
    province = order.province
    gst = subtotal * province.gst / 100
    pst = subtotal * province.pst / 100
    hst = subtotal * province.hst / 100
    qst = subtotal * province.qst / 100
    total_taxes = gst + pst + hst + qst
    total_amount = subtotal + total_taxes
    { subtotal: subtotal, gst: gst, pst: pst, hst: hst, qst: qst, total_taxes: total_taxes, total_amount: total_amount }
  end
end
