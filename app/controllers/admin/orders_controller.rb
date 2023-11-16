class Admin::OrdersController < ApplicationController
  before_action :logged_in_admin

  def show
    @order = Order.find(params[:id])
  end

  def search
    @orders = Order.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(8)
    @search_order = params[:search]
  end
end
