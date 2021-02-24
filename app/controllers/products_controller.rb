class ProductsController < ApplicationController
  def new
    # pundit: only allow if user is a baker
    @baker = current_user
    @product = Product.new
    @slot = Slot.new
  end

  def create
    @baker = current_user
    @product = Product.new(strong_params)
    @product.user = current_user
    @slot = Slot.new(strong_params_slots)
    @slot.time_period = 'unselected'
    if @product.save
      @slot.product = @product
      @slot.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def strong_params
    params.require(:product).permit(:name, :price, :description)
  end

  def strong_params_slots
    params.require(:slot).permit(:available_quantity)
  end
end
