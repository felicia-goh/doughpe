class UsersController < ApplicationController
  def index
    @bakers = User.where(baker: true)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(strong_edit_params)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  private

  def strong_edit_params
    params.require(:user).permit(:name, :bio, :address, :photo)
  end
end
