class AdminShopsController < ApplicationController
  def new
    @admin_shop = AdminShop.new
  end

  def create
    @admin_shop = AdminShop.new(user_params)
    if @admin_shop.save
      flash[:success] = 'Success'
      redirect_to(root_url)
    else
      render('new')
    end
  end

  def destroy; end

  private

  def user_params
    params.require(:admin_shop).permit(:name, :email, :password, :password_confirmation, :address, :phone, :tax_code)
  end
end
