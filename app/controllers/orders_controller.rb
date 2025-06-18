class OrdersController < ApplicationController
  # orders_controller.rb
  def create
    @order = current_user.orders.create(payment_method: nil, status: "pending")
    @order.order_items.create(menu_item_id: params[:menu_item_id], quantity: 1)
    redirect_to edit_order_path(@order)
  end

  def edit
    @order = current_user.orders.find(params[:id])
  end

  def update
    @order = current_user.orders.find(params[:id])
    @order.update(order_params.merge(status: "placed"))
    redirect_to order_success_path
  end

  def success
  end
  def bulk_create
    cart_items = current_user.cart_items.includes(:menu_item)

    # Create one order to hold all items
    order = Order.create(user: current_user, status: "pending")

    cart_items.each do |cart_item|
      OrderItem.create(order: order, menu_item: cart_item.menu_item, quantity: 1)
    end

    cart_items.destroy_all

    redirect_to customer_orders_path, notice: "All items booked successfully!"
  end



  private

  def order_params
    params.require(:order).permit(:payment_method)
  end

end
