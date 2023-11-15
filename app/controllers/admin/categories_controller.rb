class Admin::CategoriesController < ApplicationController
  before_action :logged_in_admin
  before_action :set_category, only: %i[show edit update destroy]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all.page(params[:page]).per(5)
  end

  def show
    @products = @category.products.page(params[:page]).per(5).order(created_at: :desc)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Create category success.'
      redirect_to(admin_categories_url)
    else
      render('new')
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Category updated.'
      redirect_to(admin_categories_url)
    else
      render('form')
    end
  end

  def destroy
    @category.products.each do |product|
      next unless product.categories.count == 1

      cart_item = CartItem.find_by(product_id: product.id)
      cart_item.destroy
      product.destroy
    end
    @category.product_categories.destroy_all
    @category.destroy
    flash[:success] = 'Category deleted.'
    redirect_to(admin_categories_url)
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
