class StaticPagesController < ApplicationController
  before_action :check_admin

  def home
    @products = Product.all
  end

  def show; end

  def help; end

  private

  def check_admin
    return unless admin_logged_in?

    render('errors/404')
  end
end
