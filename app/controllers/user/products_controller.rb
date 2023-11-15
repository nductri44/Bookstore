class User::ProductsController < ApplicationController
  def index
    @products = Product.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(8)
    @search_text = params[:search]
  end

  def show
    @product = Product.find(params[:id])
  end
end
