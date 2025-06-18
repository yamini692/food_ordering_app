class PagesController < ApplicationController

  before_action :require_login, only: [:customer_home]

  def customer_home
    # renders customer_home.html.erb
  end


  def customer_welcome
  end

  def restaurant_welcome
  end
end
