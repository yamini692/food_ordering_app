module Api
  class CustomerOrdersController < ApplicationController
    before_action :doorkeeper_authorize!

    # Fetch the user from the access token
    def current_user
      @current_user ||= User.find_by(id: doorkeeper_token[:resource_owner_id])
    end

    def api_index
      if current_user
        orders = current_user.orders.includes(:menu_item)
        render json: orders.as_json(
          include: { menu_item: { only: [:name, :price] } },
          only: [:id, :status, :quantity]
        )
      else
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
    end
  end
end
