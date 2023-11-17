class Admin::StaticPagesController < ApplicationController
  before_action :logged_in_admin

  def home
    @orders = Order.all.page(params[:page]).per(10).order(created_at: :desc)
  end
end
