class UsersController < ApplicationController
  def show_shop
    @baker = User.where(username: params[:name])
    @products = Product.where(user: @baker)
    @order = Order.new
    @user = current_user
  end
end
