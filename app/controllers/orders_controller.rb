class OrdersController < ApplicationController
  def index
    @orders = Order.where(user: current_user)
  end

  def new
    # @user = current_user
    # @order = Order.create(order_params)
    # @order.user = @user
    # @product = Product.find(params.require(:order).permit(:product_id)[:product_id])

    # @slot = Slot.find(params.require(:order).permit(slots: {})[:slots][:id])
    # @order.slot = @slot

    # @order.subtotal = @order.quantity * @product.price
    @order = []
    order_array_params.each_with_index do |order, index|
      @order[index] = Order.create(order[:order])
      @order[index].user = current_user
      @order[index].subtotal = Slot.find(order[:order][:slot_id]).product.price * order[:order][:quantity].to_f
      # @order[index].basket = Basket.find(session[:basket_id])
      if @order[index].save
        @slot.save
        redirect_to edit_order_path(@order)
      else
        render 'user/show_shop'
      end
    end

    raise
  end

  def js_create
    if session[:basket_id].nil?
      @basket = Basket.create(user: current_user)
      session[:basket_id] = @basket.id
    end
    @order = Order.new(params.permit(order: {})[:order])
    @order.user = current_user
    @order.subtotal = Slot.find(@order.slot.id).product.price * @order.quantity
    @order.basket = Basket.find(session[:basket_id])
    @order.save
    respond_to do |format|
      format.json { render json: { order: @order } }
    end
  end

  def sales
    @user = current_user
    @orders = @user.orders
  end

  def edit
    @order = Order.find(params[:id])
    @user = current_user
    @slot = Slot.find(@order.slot_id)
    @product = Product.find(@slot.product_id)
    render :edit, locals: { slot: @slot }
  end

  def update
    @order = Order.find(params[:id])
    @user = current_user
    @order.user = @user
    @slot = Slot.find(@order.slot_id)

    if @order.update(strong_order_params)
      render :payment, locals: { order: @order, user: current_user, slot: @slot }
    else
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :delivery_method, :delivery_address, :time_period)
  end

  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address)
  end

  def strong_order_params
    params.require(:order).permit(:delivery_method, :delivery_address, :quantity, :slot)
  end

  def order_array_params
    params.permit(orders: { order: {} })[:orders] # [0][:order].each_pair
  end
end
