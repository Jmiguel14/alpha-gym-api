require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get sales index included sales details and seller" do
    get sales_url, headers: @auth_headers
    sales = JSON.parse(response.body)["sales"]
    assert_response :success
    assert sales.length > 0, "Sales should not be empty"
  end

  test "should update product stock when sale detail is created" do
    product = products(:protein)
    sale = sales(:sale_1)
    initial_stock = product.quantity
    sale_detail_params = {
      sale: {
        sale_details_attributes: [ {
          product_id: product.id,
          quantity: 2,
          unit_price: 10.0,
          total_price: 20,
          discount: 0
        } ]
      }
    }

    put "/sales/#{sale.id}", params: sale_detail_params.to_json, headers: @auth_headers

    product.reload
    assert_response :success
    assert_equal initial_stock - 2, product.quantity, "Product stock should be updated"
  end
end
