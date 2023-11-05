class Admin::OrdersController < ApplicationController
  before_action :logged_in_admin

  def index
    @orders = Order.all
  end
end
