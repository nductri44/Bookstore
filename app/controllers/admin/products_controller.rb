class Admin::ProductsController < ApplicationController
  before_action :logged_in_admin
  before_action :set_product, only: %i[show edit update destroy]

  def new
    @product = Product.new
  end

  def index
    @products = Product.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(8).order(created_at: :desc)
    @search_text = params[:search]
  end

  def low_to_high
    @low_to_high = Product.all.order(price: :asc).page(params[:page]).per(8)
  end

  def high_to_low
    @high_to_low = Product.all.order(price: :desc).page(params[:page]).per(8)
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
      render('edit')
    end
  end

  def destroy
    @product.product_categories.destroy_all
    cart_item = CartItem.find_by(product_id: @product.id)
    cart_item.destroy unless cart_item.nil?
    @product.destroy
    flash[:success] = 'Product deleted.'
    redirect_to(admin_products_url)
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :author,
      :publisher,
      :price,
      :stock,
      :image,
      category_ids: []
    )
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
