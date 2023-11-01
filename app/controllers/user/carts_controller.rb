class User::CartsController < ApplicationController
  before_action :set_cart
  before_action :set_cart_item, only: %i[edit create update destroy]

  def show
    total_price
  end

  def create
    @cart_item = @cart.cart_items.build(product_id: params[:product_id])
    @cart_item.quantity ||= 0
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.save
      @cart.update(total: total_price)
      flash[:success] = 'Add to cart success!'
      redirect_to(user_cart_url(@cart))
    else
      flash[:danger] = 'Cannot add to cart!'
      render('static_pages/home')
    end
  end

  def edit; end

  def update
    if @cart_item.update(quantity: params[:quantity].to_i)
      flash[:success] = 'Update success.'
      redirect_to(user_cart_url(@cart))
    else
      flash[:danger] = 'Update failed.'
      render('edit')
    end
  end

  def destroy
    @cart_item.destroy
    flash[:success] = 'Item deleted.'
    redirect_to(user_cart_url(@cart))
  end

  def total_price
    @total_price ||= 0
    @cart.cart_items.each do |item|
      @total_price += item.product.price * item.quantity
    end
    @total_price
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
  end
end
