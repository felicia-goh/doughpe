class OrdersController < ApplicationController
  def new
    @user = current_user
    @order = Order.create(order_params)
    @order.user = @user
    @product = Product.find(params.require(:order).permit(:product_id)[:product_id].to_i)
    # @order.product = @product
    raise
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :delivery_method, :delivery_address)
  end

  def slot_params
  end
end
