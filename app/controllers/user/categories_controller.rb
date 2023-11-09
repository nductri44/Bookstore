class User::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def show
    @products = @category.products.page(params[:page]).per(4)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
