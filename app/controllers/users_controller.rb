class UsersController < ApplicationController
  def index
    @users = User.where(baker: true)
  end
end
