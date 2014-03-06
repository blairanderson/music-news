class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_admin, :admin_user

  def require_login
    unless logged_in?
      head :unprocessable_entity, json: {errors: "You do not belong there" }
      return
    end
  end

private
  def logged_in?
    current_user
  end

  def current_user
    begin
      @current_user ||= User.where(id: session[:user_id]).first if session[:user_id]
    rescue
      redirect_to logout_path
      return
    end
  end

  def current_admin
    begin
      if current_user && current_user == admin_user
        @current_admin ||= current_user
      end
    rescue
      redirect_to logout_path
      return
    end
  end

  def require_admin
    unless logged_in? && current_user == admin_user
      redirect_to root_path, notice: "Unauthorized Access"
      return
    end
  end

  def admin_user
    User.where(uid: "14828267").first
  end

end
