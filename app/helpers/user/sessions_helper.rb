module User::SessionsHelper
  # Logs in the given user.
  def user_log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.encrypted[:user_id] = { value: user.id, expires: 2.minutes.from_now.utc }
    cookies[:remember_token] = { value: user.remember_token, expires: 2.minutes.from_now.utc }
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        user_log_in(user)
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user && user == current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def user_logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def user_forget(user)
    user.user_forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def user_log_out
    user_forget(current_user)
    session.delete(:user_id)
    @current_user = nil
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
