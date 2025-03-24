require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should response an error if the user is not authenticated" do
    get products_url
    assert_response :unauthorized
  end

  test "should get index" do
    get products_url, headers: @auth_headers
    assert_response :success
  end
end
