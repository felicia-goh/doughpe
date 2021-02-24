class PagesController < ApplicationController
  def home
    @bakers = User.where(baker: true)
    @products = Product.all
  end
end
