require "test_helper"

class RestaurantOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restaurant_orders_index_url
    assert_response :success
  end
end
