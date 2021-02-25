class UsersController < ApplicationController
  def index
    @bakers = User.where(baker: true)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(
        name: strong_edit_params[:name],
        bio: strong_edit_params[:bio],
        address: strong_edit_params[:address],
        photo: strong_edit_params[:photo]
        )
      if strong_edit_params[:order_id]
        @order = Order.find(strong_edit_params[:order_id])
        redirect_to edit_order_path(@order)
      else
        redirect_to edit_user_path(@user)
      end
    else
      render :edit
    end
  end

  private

  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address, :photo, :order_id)
  end
end
