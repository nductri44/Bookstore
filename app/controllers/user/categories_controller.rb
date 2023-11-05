class User::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show]

  def index
    @categories = Category.all
  end

  def show
    @products = @category.products
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
