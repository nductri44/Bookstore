class User::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  def new
    @cart = current_user.cart
    total_price
    check_stock

    if @messages.present?
      flash[:danger] = @messages
      redirect_to(request.referrer)
    elsif @cart_items.empty?
      @messages = ["There's something wrong. The product's stock is not enough."]
      flash[:danger] = @messages
      redirect_to(request.referrer)
    end
  end

  def show
    @orders = @user.orders.order(created_at: :desc).page(params[:page]).per(5)
  end

  def create
    @cart = current_user.cart
    check_stock
    if @messages.present?
      flash[:danger] = @messages
      redirect_to(user_carts_url)
    elsif @cart_items.empty?
      @messages = ["There's something wrong. The product's stock is not enough."]
      flash[:danger] = @messages
      redirect_to(user_carts_url)
    else
      @order = @user.orders.build(
        total: params[:total],
        name: params[:name],
        email: params[:email],
        address: params[:address],
        phone: params[:phone]
      )
      if @order.save
        create_order_items
        clear_cart_items
        send_order_email
        flash[:success] = 'Order created success!'
        redirect_to(home_url)
      else
        flash[:danger] = 'Cannot create order!'
        redirect_to(request.referrer)
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def check_stock
    @cart_items = current_user.cart.cart_items
    @messages =
      @cart_items.each_with_object([]) do |item, messages|
        messages << "#{item.product.name}'s stock is not enough!" if item.quantity.to_i > item.product.stock.to_i
      end
  end

  def create_order_items
    @cart_items = current_user.cart.cart_items
    @cart_items.each do |item|
      @order_item = @order.order_items.build(
        product_id: item.product_id,
        name: item.product.name,
        price: item.product.price,
        quantity: item.quantity
      )

      product = item.product
      if product.image.attached?
        image_blob = product.image.blob
        @order_item.image.attach(image_blob)
      end

      @order_item.save
    end
    @order_items = @order.order_items
  end

  def clear_cart_items
    @cart_items = current_user.cart.cart_items
    @cart_items.destroy_all
  end

  def send_order_email
    UserMailer.order_complete(@user, @order, @order_items).deliver_now
    AdminMailer.order_notification(Admin.first, @order, @order_items).deliver_now
  end

  def total_price
    @total_price =
      @cart.cart_items.reduce(0) do |sum, item|
        sum + (item.product.price * item.quantity.to_i)
      end
  end
end
