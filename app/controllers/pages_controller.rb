class PagesController < ApplicationController
  def home
    if params[:query].present?
      @bakers = User.where("lower(username) LIKE ? AND baker= ?", "%#{params[:query].downcase}%", true)
    else
      @bakers = User.where(baker: true)
    end

    if params[:query].present?
      @products = Product.where("lower(name) LIKE ?", "%#{params[:query].downcase}%")
    else
      @products = Product.all
    end
  end
end
