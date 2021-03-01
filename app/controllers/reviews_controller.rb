class ReviewsController < ApplicationController
  def shows
    @review = Review.find(params[:order_id])
  end

  def new
    @order = Order.find(params[:order_id])
    @review = Review.new
    @review.order_id = @order.id
     respond_to do |format|
      format.html { render 'new' }
      format.js
    end
  end

  def create
    @order = Order.find(params[:order_id])
    @review = Review.new(review_params)
    @review.order_id = @order.id
    if @review.save
      redirect_to orders_path
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :order_id)
  end
end
