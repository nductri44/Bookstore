class User::PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]    # Case (1)

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to(root_url)
    else
      flash.now[:danger] = 'Email address not found'
      render('new')
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty? # Case (3)
      @user.errors.add(:password, "can't be empty")
      render('edit')
    elsif @user.update(user_params) # Case (4)
      user_log_in(@user)
      flash[:success] = 'Password has been reset.'
      redirect_to(root_url)
    else
      render('edit') # Case (2)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # Before filters

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # Confirms a valid user.
  def valid_user
    return if @user && @user.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to(root_url)
  end

  # Checks expiration of reset token.
  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = 'Password reset has expired.'
    redirect_to(new_user_password_reset_url)
  end
end
