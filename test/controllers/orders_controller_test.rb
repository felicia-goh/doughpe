require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get track" do
    get orders_track_url
    assert_response :success
  end

end
