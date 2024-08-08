# app/controllers/order_items_controller.rb
class OrderItemsController < ApplicationController
  def create
    product = Product.find(params[:order_item][:product_id])
    order_item = {
      "product_id" => product.id,
      "quantity"   => params[:order_item][:quantity].to_i,
      "price"      => product.price
    }

    session[:cart] ||= []
    existing_item = session[:cart].find { |item| item["product_id"] == product.id }
    if existing_item
      existing_item["quantity"] += order_item["quantity"]
    else
      session[:cart] << order_item
    end

    redirect_to cart_path, notice: "Product added to cart."
  end

  def update
    product_id = params[:order_item][:product_id].to_i
    quantity = params[:order_item][:quantity].to_i

    session[:cart] ||= []
    cart_item = session[:cart].find { |item| item["product_id"] == product_id }
    cart_item["quantity"] = quantity if cart_item

    redirect_to cart_path, notice: "Product quantity updated."
  end

  def destroy
    product_id = params[:id].to_i

    session[:cart] ||= []
    session[:cart].reject! { |item| item["product_id"] == product_id }

    redirect_to cart_path, notice: "Product removed from cart."
  end
end
