class Admin::AccountActivationsController < ApplicationController
  def edit
    admin = Admin.find_by(email: params[:email])
    if admin && !admin.activated? && admin.authenticated?(:activation, params[:id])
      admin.update_attribute(:activated, true)
      admin.update_attribute(:activated_at, Time.zone.now)
      admin_log_in(admin)
      flash[:success] = 'Account activated!'
      redirect_to(admin_url)
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to(admin_url)
    end
  end
end
