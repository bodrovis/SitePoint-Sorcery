class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = 'You have to authenticate to access this page.'
    redirect_to log_in_path
  end

  def current_users
    User.current_users
  end

  helper_method :current_users
end