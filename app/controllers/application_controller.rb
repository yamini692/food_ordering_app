class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      flash[:alert] = "You must log in first."
      redirect_to login_path
    end
  end
  def require_customer
    unless current_user&.customer?
      redirect_to login_path, alert: "You must be logged in as a customer"
    end
  end
end
