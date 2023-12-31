class User::UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index show edit update destroy]
  before_action :find_user, only: %i[show destroy]
  before_action :correct_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.create_cart!
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to(home_url)
    else
      render('new')
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to(home_url)
    else
      render('edit')
    end
  end

  private

  def check_admin
    render('errors/404') if admin_logged_in?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :phone)
  end

  # Finds the user.
  def find_user
    @user = User.find(params[:id])
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(home_url) unless current_user?(@user)
  end
end
