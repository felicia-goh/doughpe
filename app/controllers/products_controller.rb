class ProductsController < ApplicationController
  def new
    # pundit: only allow if user is a baker
    @product = Product.new
    @slot = Slot.new
  end

  def create
    @product = Product.new(strong_params)
    @product.user = current_user
    quantity = strong_params_slots['available_quantity']
    dates = strong_params_slots['date'].select { |d| d != '' }
    if @product.save
      dates.each do |date|
        @slot = Slot.new(available_quantity: quantity, date: date)
        @slot.product = @product
        @slot.time_period = 'unselected'
        @slot.save
      end
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
    params.require(:slot).permit(:available_quantity, date: [])
  end
end
