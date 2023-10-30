class Admin::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def show
    @products = Product.all
  end

  def create
    @product = Product.new(product_params)
    @product.image.attach(params[:product][:image])
    if @product.save
      flash[:success] = 'Create product success.'
      redirect_to(root_url)
    else
      render('new')
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :author, :publisher, :price, :stock, :image)
  end
end
