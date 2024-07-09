class CategoriesController < ApplicationController
    def show
      @category = Category.find(params[:id])
      @products = @category.products.page(params[:page]).per(10)  # Paginate products
      @categories = Category.all  # Ensure @categories is set
    end
  end
  