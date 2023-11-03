class ApplicationController < ActionController::Base
  include Admin::SessionsHelper
  include User::SessionsHelper

  private

  # Confirms a logged-in user.
  def logged_in_user
    return if user_logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to(login_url)
  end

  # Confirms a logged-in admin.
  def logged_in_admin
    return if admin_logged_in?

    store_location
    flash[:danger] = 'Please log in.'
    redirect_to(admin_login_url)
  end
end
