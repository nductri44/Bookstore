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
      process_cart_item(add)
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

  def process_cart_item(add)
    @cart_item = @cart.cart_items.find_or_initialize_by(product_id: add[:product_id])

    return if add[:quantity].to_i.zero?

    update_cart_item(add)
    save_cart_item
    update_cart_total
  end

  def update_cart_item(add)
    return unless @cart_item.new_record? || quantity_within_stock_limit?(add)

    @cart_item.quantity += add[:quantity].to_i
  end

  def quantity_within_stock_limit?(add)
    @cart_item.quantity + add[:quantity].to_i > add[:stock].to_i
  end

  def save_cart_item
    @cart_item.save
  end

  def update_cart_total
    @cart.update(total: total_price)
  end
end
