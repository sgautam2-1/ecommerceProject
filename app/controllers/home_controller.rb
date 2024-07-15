
class HomeController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category).page(params[:page]).per(12)  # Pagination with Kaminari
  end
end
