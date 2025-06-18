# app/controllers/restaurant_orders_controller.rb
class RestaurantOrdersController < ApplicationController
  before_action :require_restaurant

  def index
    @order_items = OrderItem.joins(:menu_item, :order) .where(menu_items: { user_id: current_user.id }).where(orders: { status: "placed" }, booked: [false, nil])
  end

  def book
    @order_item = OrderItem.joins(:menu_item)
                          .where(menu_items: { user_id: current_user.id })
                          .find(params[:id])
    @order_item.update(booked: true)
    redirect_to restaurant_orders_path, notice: "Order marked as booked."
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
