class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user).order(updated_at: :desc)
  end

  def new
    @user = current_user
    @order = Order.create(order_params)
    @order.user = @user
    @product = Product.find(params.require(:order).permit(:product_id)[:product_id])
    @order.delivery_address = "self-collection" if @order.delivery_method == "self-collection"

    slot = Slot.find(params.require(:order).permit(slots: {})[:slots][:id])
    @order.slot = slot
    # @order.slot.time_period = params.require(:order).permit(slots: {})[:slots][:time_period]

    @order.subtotal = @order.quantity * @product.price

    if @order.save
      slot.save
      redirect_to edit_order_path(@order)
    else
      render 'user/show_shop'
    end
  end

  def sales
    @user = current_user
    @orders = @user.orders
  end

  def edit
    @order = Order.find(params[:id])
    @user = current_user
    @basket = Order.where(basket: @order.basket_id)
    @completed = Order.where(basket: @order.basket_id).first.basket.completed
    #@order.update(order_params_test)
    render :edit
  end

  def update
    @order = Order.find(params[:id])
    @user = current_user
    @order.user = @user
    @basket = Order.where(basket: @order.basket_id)

    if @order.update(order_params)
      render :success, locals: { order: @order, user: current_user, basket: @basket}
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :delivery_method, :delivery_address, :subtotal)
  end
  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address)
  end
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
