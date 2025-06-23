class ApplicationController < ActionController::Base
  # Devise provides current_user, no need to redefine it
  before_action :authenticate_user!

  # Optional: check customer role
  def require_customer
    unless current_user&.role == "Customer"
      redirect_to new_user_session_path, alert: "You must be logged in as a customer"
    end
  end

  # Optional: check restaurant role
  def require_restaurant
    unless current_user&.role == "Restaurant"
      redirect_to new_user_session_path, alert: "You must be logged in as a restaurant"
    end
  end
end
