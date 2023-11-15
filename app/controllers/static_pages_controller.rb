class StaticPagesController < ApplicationController
  before_action :check_admin

  def home
    best_sellers
    @new_arrivals = Product.order(created_at: :desc)
  end

  def show; end

  def help; end

  private

  def check_admin
    return unless admin_logged_in?

    render('errors/404')
  end

  def best_sellers
    @best_sellers = Product
                    .joins(:order_items)
                    .group(:id)
                    .select('products.*, SUM(order_items.quantity) as total_quantity')
                    .order('total_quantity DESC')
                    .limit(4)
  end
end
