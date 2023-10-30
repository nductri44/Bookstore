module Admin::SessionsHelper
  # Logs in the given admin.
  def admin_log_in(admin)
    session[:admin_id] = admin.id
  end

  # Remembers an admin in a persistent session.
  def admin_remember(admin)
    admin.admin_remember
    cookies.encrypted[:admin_id] = { value: admin.id, expires: 2.minutes.from_now.utc }
    cookies[:remember_token] = { value: admin.remember_token, expires: 2.minutes.from_now.utc }
  end

  # Returns the current logged-in admin (if any).
  def current_admin
    if (admin_id = session[:admin_id])
      @current_admin ||= Admin.find_by(id: admin_id)
    elsif (admin_id = cookies.encrypted[:admin_id])
      admin = Admin.find_by(id: admin_id)
      if admin && admin.authenticated?(:remember, cookies[:remember_token])
        admin_log_in(admin)
        @current_admin = admin
      end
    end
  end

  # Returns true if the given admin is the current admin.
  def current_admin?(admin)
    admin && admin == current_admin
  end

  # Returns true if the admin is logged in, false otherwise.
  def admin_logged_in?
    !current_admin.nil?
  end

  # Forgets a persistent session.
  def admin_forget(admin)
    admin.admin_forget
    cookies.delete(:admin_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current admin.
  def admin_log_out
    admin_forget(current_admin)
    session.delete(:admin_id)
    @current_admin = nil
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
