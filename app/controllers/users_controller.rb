class UsersController < ApplicationController
  def index
    @bakers = User.where(baker: true)
  end
end
