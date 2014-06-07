class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_admin, :admin_user


private

  def current_admin
    begin
      if current_account && current_account == admin_account
        @current_admin ||= current_user
      end
    rescue
      redirect_to logout_path
      return
    end
  end

  def require_admin
    unless current_account && current_account == admin_account
      redirect_to root_path, notice: "Unauthorized Access"
      return
    end
  end

  def admin_account
    Identity.where(uid: "14828267", provider: "twitter").first.try(:account)
  end

end
