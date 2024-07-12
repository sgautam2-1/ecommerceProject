# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
    calculate_total_with_taxes
  end

  private

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
