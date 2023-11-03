class User::CartsController < ApplicationController
  before_action :logged_in_user
  before_action :set_cart
  before_action :set_cart_item, only: %i[edit update destroy]

  def show
    @cart = Cart.find(params[:id])
    total_price
  end

  def create
    @cart_item = @cart.cart_items.find_by(product_id: params[:product_id])
    if @cart_item
      @cart_item.update(quantity: @cart_item.quantity + params[:quantity].to_i)
    else
      @cart_item = @cart.cart_items.build(product_id: params[:product_id], quantity: params[:quantity].to_i)
    end
    if @cart_item.save
      @cart.update(total: total_price)
      flash[:success] = 'Add to cart success!'
      redirect_to(user_cart_url(@cart))
    else
      flash[:danger] = 'Cannot add to cart!'
      render('home')
    end
  end

  def edit; end

  def update
    if @cart_item.update(cart_item_params)
      flash[:success] = 'Update success.'
      redirect_to(user_cart_url(@cart))
    else
      flash[:danger] = 'Update failed.'
      render('edit')
    end
  end

  def destroy
    @cart_item.destroy
    flash[:success] = 'Delete item success'
    redirect_to(user_cart_url(@cart))
  end

  def total_price
    @total_price ||= 0
    @cart.cart_items.each do |item|
      @total_price += item.product.price * item.quantity.to_i
    end
    @total_price
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find_by(id: params[:id])
  end
end
