class Admin::AdminsController < ApplicationController
  before_action :logged_in_admin, only: %i[index show edit update destroy]
  before_action :find_admin, only: %i[show destroy]
  before_action :correct_admin, only: %i[edit update]

  def new
    @hidden_header = true
    @admin = Admin.new
  end

  def show; end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      AdminMailer.account_activation(@admin).deliver_now
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to(admin_url)
    else
      render('new')
    end
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      flash[:success] = 'Profile updated'
      redirect_to(admin_admin_path)
    else
      render('edit')
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = 'Admin deleted'
    redirect_to(admin_url)
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation, :address, :phone, :tax_code)
  end

  # Finds the admin.
  def find_admin
    @admin = Admin.find(params[:id])
  end

  # Confirms the correct admin.
  def correct_admin
    @admin = Admin.find(params[:id])
    redirect_to(home_url) unless current_admin?(@admin)
  end
end
