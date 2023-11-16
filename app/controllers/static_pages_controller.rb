class StaticPagesController < ApplicationController
  before_action :check_admin

  def home
    @best_sellers = Product
                    .select('products.*, SUM(order_items.quantity) as total_quantity')
                    .joins(:order_items)
                    .group(:id)
                    .order('total_quantity DESC')
                    .limit(4)
    @new_arrivals = Product.order(created_at: :desc)
  end

  def show; end

  def help; end

  private

  def check_admin
    return unless admin_logged_in?

    render('errors/404')
  end
end
