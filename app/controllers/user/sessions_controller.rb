class User::SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        user_log_in(user)
        params[:session][:remember_me] == '1' ? user_remember(user) : user_forget(user)
        redirect_back_or(home_path)
      else
        message = 'Account not activated.'
        message += ' Check your email for the activation link.'
        flash[:warning] = message
        redirect_to(user_login_path)
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render('new')
    end
  end

  def destroy
    user_log_out
    redirect_to(home_path)
  end
end
