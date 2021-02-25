class OrdersController < ApplicationController
  def track
    @order = Order.find(params[:order_id])
  end
end
