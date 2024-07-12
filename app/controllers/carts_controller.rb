# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    if session[:cart].present?
      product_ids = session[:cart].map { |item| item["product_id"] }
      @products = Product.where(id: product_ids)
      @cart_items = session[:cart]
    else
      @products = []
      @cart_items = []
    end
  end

  def add_item
    product_id = params[:order_item][:product_id].to_i
    quantity = params[:order_item][:quantity].to_i

    order_item = {
      "product_id" => product_id,
      "quantity" => quantity
    }

    session[:cart] ||= []
    existing_item = session[:cart].find { |item| item["product_id"] == product_id }

    if existing_item
      existing_item["quantity"] += quantity
    else
      session[:cart] << order_item
    end

    redirect_to cart_path, notice: "Product added to cart."
  end

  def remove_item
    product_id = params[:id].to_i

    session[:cart] ||= []
    session[:cart].reject! { |item| item["product_id"] == product_id }

    redirect_to cart_path, notice: "Product removed from cart."
  end

  def update_quantity
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i

    session[:cart] ||= []
    item = session[:cart].find { |item| item["product_id"] == product_id }

    if item
      item["quantity"] = quantity
    end

    redirect_to cart_path, notice: "Cart updated successfully."
  end

  def checkout
    redirect_to new_checkout_path
  end
end
