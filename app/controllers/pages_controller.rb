class PagesController < ApplicationController
  def home
    @bakers = User.where(baker: true)
    @products = Product.all
  end

  def search
    if params[:query].present?
      @query = params[:query]
      @bakers_results = User.search_name_and_product(@query)
      @products_results = Product.search_name_and_desc(@query)
    end
  end
end
