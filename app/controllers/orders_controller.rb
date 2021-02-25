class OrdersController < ApplicationController

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

  def order_params
    params.require(:order).permit(:quantity, :delivery_method, :delivery_address)
  end

  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address)
  end

  def strong_order_params
    params.require(:order).permit(:delivery_method, :delivery_address, :quantity, :slot)
end
