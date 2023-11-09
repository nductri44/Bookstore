class User::CartsController < ApplicationController
  before_action :logged_in_user
  before_action :set_cart
  before_action :set_cart_item, only: %i[edit destroy]

  def show
    total_price
  end

  def create
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    if params[:quantity].to_i > params[:stock].to_i
      flash[:danger] = 'Not enough stock!'
      redirect_to(request.referrer)
    else
      if @cart_item
        @cart_item.update(quantity: @cart_item.quantity + params[:quantity].to_i)
      else
        @cart_item = @cart.cart_items.build(product_id: params[:product_id], quantity: params[:quantity].to_i)
      end
      if @cart_item.save
        flash[:success] = 'Add to cart success!'
        @cart.update(total: total_price)

        redirect_to(request.referrer)
      else
        flash[:danger] = 'Cannot add to cart!'
      end
    end
  end

  def update_cart
    updates = params[:updates]
    updates.each do |update|
      @cart_item = CartItem.find_by(product_id: update[:product_id])
      @cart_item.update(quantity: update[:quantity]) if @cart_item
    end

    @cart = current_user.cart
    @cart.update(total: total_price)
  end

  def destroy
    @cart_item.destroy
    @cart.update(total: total_price)
    flash[:success] = 'Delete item success'
    redirect_to(user_cart_url(@cart))
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find_by(id: params[:id])
  end

  def total_price
    price = []
    @cart.cart_items.each do |item|
      price << (item.product.price * item.quantity.to_i)
    end
    @total_price = price.sum
  end
end
