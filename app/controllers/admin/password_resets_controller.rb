class Admin::PasswordResetsController < ApplicationController
  before_action :get_admin, only: %i[edit update]
  before_action :valid_admin, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]    # Case (1)

  def new; end

  def create
    @admin = Admin.find_by(email: params[:password_reset][:email].downcase)
    if @admin
      @admin.create_reset_digest
      @admin.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to(root_url)
    else
      flash.now[:danger] = 'Email address not found'
      render('new')
    end
  end

  def edit; end

  def update
    if params[:admin][:password].empty? # Case (3)
      @admin.errors.add(:password, "can't be empty")
      render('edit')
    elsif @admin.update(admin_params) # Case (4)
      admin_log_in(@admin)
      flash[:success] = 'Password has been reset.'
      redirect_to(@admin)
    else
      render('edit') # Case (2)
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_admin
    @admin = Admin.find_by(email: params[:email])
  end

  # Confirms a valid admin.
  def valid_admin
    return if @admin && @admin.activated? && @admin.authenticated?(:reset, params[:id])

    redirect_to(root_url)
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @admin.password_reset_expired?

    flash[:danger] = 'Password reset has expired.'
    redirect_to(new_password_reset_url)
  end
end
