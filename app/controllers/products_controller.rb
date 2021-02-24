class ProductsController < ApplicationController
  def new
    # pundit: only allow if user is a baker
    @baker = current_user
    @product = Product.new
  end

  def create
    @baker = current_user
    @product = Product.new(strong_params)
    @product.user = current_user

    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:product).permit(:name, :price, :description)
  end
end
