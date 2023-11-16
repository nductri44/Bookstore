class User::ProductsController < ApplicationController
  def index
    @products = Product.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(8)
    @search_text = params[:search]
  end

  def best_sellers
    @best_sellers = Product
                    .select('products.*, SUM(order_items.quantity) as total_quantity')
                    .joins(:order_items)
                    .group(:id)
                    .order('total_quantity DESC')
                    .limit(8)
  end

  def new_arrivals
    @new_arrivals = Product.order(created_at: :desc)
  end

  def low_to_high
    @low_to_high = Product.all.order(price: :asc).page(params[:page]).per(8)
  end

  def high_to_low
    @high_to_low = Product.all.order(price: :desc).page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
  end
end
