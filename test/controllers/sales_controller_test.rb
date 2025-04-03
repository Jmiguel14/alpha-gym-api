require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get sales index included sales details and seller" do
    get sales_url, headers: @auth_headers
    sales = JSON.parse(response.body)["sales"]
    sales_details = sales.dig(0, "sale_details")
    seller = sales.dig(0, "seller")
    assert_response :success
    assert sales.length > 0, "Sales should not be empty"
    assert sales_details&.length > 0, "Sales details should not be empty"
    assert_not_nil seller, "Seller should not be nil"
    assert_nil seller["jti"]
  end
end
