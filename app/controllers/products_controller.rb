# app/controllers/products_controller.rb

class ProductsController < ApplicationController
  before_action :set_categories, only: [:index, :show, :new_arrivals, :recently_updated]
  before_action :set_product, only: [:show]

  def index
    @products = Product.page(params[:page]).per(10)
    filter_products
  end

  def show
  end

  def new_arrivals
    @products = Product.where("created_at >= ?", 1.hour.ago).page(params[:page]).per(10)
    filter_products
    render :index
  end

  def recently_updated
    @products = Product.where("updated_at >= ?", 1.hour.ago).page(params[:page]).per(10)
    filter_products
    render :index
  end

  private

  def set_categories
    @categories = Category.includes(:products)
  end

  def filter_products
    if params[:search].present?
      @products = @products.where("name LIKE ?", "%#{params[:search]}%")
    end

    if params[:category].present? && params[:category] != ""
      @products = @products.where(category_id: params[:category])
    end

    if params[:filter] == 'new_arrivals'
      @products = @products.where("created_at >= ?", 1.hour.ago)
    elsif params[:filter] == 'recently_updated'
      @products = @products.where("updated_at >= ?", 1.hour.ago)
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
