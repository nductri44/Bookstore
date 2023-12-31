class User::AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      user_log_in(user)
      flash[:success] = 'Account activated!'
      redirect_to(home_url)
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to(home_url)
    end
  end
end
