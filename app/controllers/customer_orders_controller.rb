class CustomerOrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user.id)  # or however you identify customer
  end
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to customer_orders_path, notice: "Order deleted successfully."
  end

end
