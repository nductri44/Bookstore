class User::CartsController < ApplicationController
  before_action :logged_in_user
  before_action :set_cart

  def index
    @flash_loop = true
    total_price
  end

  def add_to_cart
    adds = params[:adds]
    adds.each do |add|
      @cart_item = @cart.cart_items.find_by(product_id: add[:product_id])
      next if add[:quantity].to_i > add[:stock].to_i || add[:quantity].to_i == 0

      if @cart_item
        new_quantity = @cart_item.quantity + add[:quantity].to_i
        if new_quantity > add[:stock].to_i
          @cart_item.update(quantity: @cart_item.quantity)
        else
          @cart_item.update(quantity: new_quantity)
        end
      else
        @cart_item = @cart.cart_items.build(product_id: add[:product_id], quantity: add[:quantity].to_i)
      end

      @cart_item.save
      @cart.update(total: total_price)
    end
  end

  def update_cart
    updates = params[:updates]
    updates.each do |update|
      @cart_item = @cart.cart_items.find_by(product_id: update[:product_id])
      @cart_item.update(quantity: update[:quantity].to_i) if @cart_item
      @cart_item.save
    end

    @cart = current_user.cart
    @cart.update(total: total_price)
  end

  def destroy
    @cart_item = @cart.cart_items.find_by(id: params[:id])
    @cart_item.destroy
    @cart.update(total: total_price)
    flash[:success] = 'Delete item success'
    redirect_to(user_carts_url)
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def total_price
    @total_price =
      @cart.cart_items.reduce(0) do |sum, item|
        sum + (item.product.price * item.quantity.to_i)
      end
  end
end
