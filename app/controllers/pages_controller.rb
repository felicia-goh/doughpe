class PagesController < ApplicationController
  def home
    @bakers = User.where(baker: true)
    @products = Product.all

    if params[:query].present?
      @query = params[:query]
      @bakers_results = User.where("lower(username) LIKE ? AND baker= ?", "%#{params[:query].downcase}%", true)
      @products_results = Product.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    end
  end
end
