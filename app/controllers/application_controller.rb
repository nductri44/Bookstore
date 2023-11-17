class ApplicationController < ActionController::Base
  include Admin::SessionsHelper
  include User::SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    render(template: 'errors/404', status: 404, layout: 'application', content_type: 'text/html')
  end

  private

  # Confirms a logged-in user.
  def logged_in_user
    if admin_logged_in?
      render('errors/404')
    elsif user_logged_in?
      nil
    else
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to(user_login_url)
    end
  end

  # Confirms a logged-in admin.
  def logged_in_admin
    if user_logged_in?
      render('errors/404')
    elsif admin_logged_in?
      nil
    else
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to(admin_login_url)
    end
  end
end
