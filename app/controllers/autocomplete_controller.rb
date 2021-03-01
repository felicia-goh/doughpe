class AutocompleteController < ApplicationController
  def index
    @bakers = User.where("users.username ILIKE ?", "%#{params[:query]}%")
    @products = Product.where("name ILIKE ?", "%#{params[:query]}%")
    @results = @bakers + @products
    respond_to do |format|
      format.json { render json: { suggestions: @results.first(5) } }
    end
  end
end
