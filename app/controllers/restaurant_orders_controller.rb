class RestaurantOrdersController < ApplicationController
  before_action :require_restaurant

  def index
    @order_items = current_user.menu_items.includes(:unbooked_order_items).flat_map(&:unbooked_order_items)
  end
  
  def book
    @order_item = OrderItem.belonging_to_restaurant(current_user.id).find(params[:id])
    @order_item.update(booked: true)
  end
  def update
    @order = Order.find(params[:id])
    if @order.update(status: "delivered")
      redirect_to restaurant_orders_path, notice: "Order marked as delivered!"
    else
      redirect_to restaurant_orders_path, alert: "Failed to update order."
    end
  end
  private

  def require_restaurant
    redirect_to root_path unless current_user&.role == "Restaurant"
  end
end
