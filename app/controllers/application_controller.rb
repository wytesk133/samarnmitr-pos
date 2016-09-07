class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil
  end

  def authenticate
    redirect_to :login unless logged_in?
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def authenticate_admin
    authenticate
    not_found unless current_user.is_admin?
  end

  def admin_sidebar
    @admin_sidebar = true
  end
end
