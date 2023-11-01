class StaticPagesController < ApplicationController
  def home
    @products = Product.all
  end

  def show; end

  def help; end
end
