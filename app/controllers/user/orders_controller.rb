class User::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :set_user
  before_action :set_cart_items, only: %i[create]

  def new
    @flash_loop = true
    @cart = current_user.cart
  end

  def show
    @orders = @user.orders.order(created_at: :desc).page(params[:page]).per(5)
  end

  def create
    check_stock
    if @messages.empty?
      @order = @user.orders.build(
        total: params[:total],
        name: params[:name],
        email: params[:email],
        address: params[:address],
        phone: params[:phone]
      )
      if @order.save
        create_order_items
        send_order_email
        flash[:success] = 'Order created success!'
        redirect_to(home_url)
      else
        flash[:danger] = 'Cannot create order!'
        redirect_to(request.referrer)
      end
    else
      flash[:danger] = @messages
      redirect_to(request.referrer)
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_cart_items
    @cart_items = @user.cart.cart_items
  end

  def create_order_items
    @cart_items.each do |item|
      @order_item = @order.order_items.build(
        product_id: item.product_id,
        price: item.product.price,
        quantity: item.quantity
      )
      @order_item.save!
    end
    @order_items = @order.order_items
  end

  def check_stock
    @messages = []
    @cart_items.each do |item|
      @messages << "#{item.product.name}'s stock is not enough!" if item.quantity.to_i > item.product.stock.to_i
    end
    @messages
  end

  def send_order_email
    UserMailer.order_complete(@user, @order, @order_items).deliver_now
    AdminMailer.order_notification(Admin.first, @order, @order_items).deliver_now
  end
end
