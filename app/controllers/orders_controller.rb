class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user)
  end

  def new
    @user = current_user
    @order = Order.create(order_params)
    @order.user = @user
    @product = Product.find(params.require(:order).permit(:product_id)[:product_id])
    @order.delivery_address = "self-collection" if @order.delivery_method == "self-collection"

    slot = Slot.find(params.require(:order).permit(slots: {})[:slots][:id])
    @order.slot = slot
    @order.slot.time_period = params.require(:order).permit(slots: {})[:slots][:time_period]
    @order.total = @order.quantity * @product.price
    if @order.save
      redirect_to edit_order_path(@order)
    else
      render 'user/show_shop'
    end
  end

  def sales
    @user = current_user
    @orders = @user.orders
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :delivery_method, :delivery_address)
  end
end
