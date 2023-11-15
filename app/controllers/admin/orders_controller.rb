class Admin::OrdersController < ApplicationController
  before_action :logged_in_admin

  def show
    @order = Order.find(params[:id])
  end
end
