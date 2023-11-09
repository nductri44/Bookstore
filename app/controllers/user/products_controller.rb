class User::ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @products = Product.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(4)
    @search_text = params[:search]
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
