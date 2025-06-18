class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] =user.id

      if user.role == "Restaurant"
        redirect_to restaurant_welcome_path
      elsif user.role == "Customer"
        redirect_to customer_home_path
      else
        redirect_to root_path, alert: "Unknown user type"
      end
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
