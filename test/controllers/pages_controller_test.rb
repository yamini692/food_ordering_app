require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get customer_welcome" do
    get pages_customer_welcome_url
    assert_response :success
  end

  test "should get restaurant_welcome" do
    get pages_restaurant_welcome_url
    assert_response :success
  end
end
