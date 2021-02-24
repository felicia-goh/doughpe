require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get index" do
    get users_index_url
    assert_response :success
  end

>>>>>>> 749231897706b1f38fac635687a1d0775a4e8f20
end
