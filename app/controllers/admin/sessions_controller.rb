class Admin::SessionsController < ApplicationController
  def new
    @hidden_header = true
  end

  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      if admin.activated?
        admin_log_in(admin)
        params[:session][:remember_me] == '1' ? admin_remember(admin) : admin_forget(admin)
        redirect_back_or(admin_path)
      else
        message = 'Account not activated.'
        message += ' Check your email for the activation link.'
        flash[:warning] = message
        redirect_to(admin_login_path)
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render('new')
    end
  end

  def destroy
    admin_log_out
    redirect_to(admin_path)
  end
end
