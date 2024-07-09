class ProductsController < ApplicationController
  before_action :set_categories, only: [:index, :new_arrivals, :recently_updated]

  def index
    @products = if params[:filter].present?
                  case params[:filter]
                  when "new_arrivals"
                    Product.where("created_at >= ?", 1.minute.ago).page(params[:page]).per(10)
                  when "recently_updated"
                    Product.where("updated_at >= ?", 1.minute.ago).page(params[:page]).per(10)
                  else
                    Product.page(params[:page]).per(10)
                  end
                else
                  Product.page(params[:page]).per(10)
                end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new_arrivals
    @products = Product.where("created_at >= ?", 1.minute.ago).page(params[:page]).per(10)
    render :index
  end

  def recently_updated
    @products = Product.where("updated_at >= ?", 1.minute.ago).page(params[:page]).per(10)
    render :index
  end

  private

  def set_categories
    @categories = Category.includes(:products)
  end
end
