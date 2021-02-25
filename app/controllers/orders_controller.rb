class OrdersController < ApplicationController
  def edit
    @order = Order.find(params[:id])
    @user = current_user
    @slot = Slot.find(@order.slot_id)
    @product = Product.find(@slot.product_id)
    render :edit, locals: { slot: @slot}
  end

  def update
    @order = Order.find(params[:id])
    @user = current_user
    @order.user = @user
    @slot = Slot.find(@order.slot_id)

    if @order.update(strong_order_params)
      render :payment, locals: { order: @order, user: current_user, slot: @slot}
    else
      render :edit
    end
  end

  private
  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address)
  end
  def strong_order_params
    params.require(:order).permit(:delivery_method, :delivery_address, :quantity, :slot)
  end
end
