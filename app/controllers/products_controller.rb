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
    dates = strong_params_slots['date'].split(",")
    if @product.save
      dates.each do |date|
        @slot = Slot.new(available_quantity: quantity, date: date)

        @slot.product = @product
        @slot.save
      end
      redirect_to baker_path(current_user.username)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    quantity = strong_params_slots['available_quantity']
    dates = strong_params_slots['date'].reject { |d| d == '' }
    if @product.update(strong_params)
      unless dates.empty?
        dates.each do |date|
          @slot = Slot.new(available_quantity: quantity, date: date)
          @slot.product = @product
          @slot.save
        end
      end
      @baker = current_user
      redirect_to baker_path(@baker.username)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      @baker = current_user
      redirect_to baker_path(@baker.username)
    else
      render 'baker/show_shop'
    end
  end

  private

  def strong_params
    params.require(:product).permit(:name, :price, :description, :photo)
  end

  def strong_params_slots
    params.require(:slot).permit(:available_quantity, :date)
  end
end
