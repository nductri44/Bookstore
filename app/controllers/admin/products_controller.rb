class Admin::ProductsController < ApplicationController
  before_action :logged_in_admin
  before_action :set_product, only: %i[show edit update destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
  end

  def show; end

  def create
    @product = Product.new(product_params)
    @product.image.attach(params[:product][:image])
    if @product.save
      flash[:success] = 'Create product success.'
      redirect_to(admin_products_url)
    else
      render('new')
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = 'Product updated.'
      redirect_to(admin_products_url)
    else
      render('form')
    end
  end

  def destroy
    @product.destroy
    flash[:success] = 'Product deleted.'
    redirect_to(admin_products_url)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_ids, :author, :publisher, :price, :stock, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
