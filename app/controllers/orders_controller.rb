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
    order = BulkOrderCreator.new(current_user).call

    if order
      redirect_to edit_order_path(order), notice: "Please choose a payment method to confirm your order."
    else
      redirect_to cart_items_path, alert: "Your cart is empty!"
    end
  end



  private

  def order_params
    params.require(:order).permit(:payment_method)
  end

end
