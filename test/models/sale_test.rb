require "test_helper"

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should return sales revenue by seller" do
    seller = users(:juan)
    user_total_sales = seller.total_sales_revenue
    assert user_total_sales > 0
    assert_equal 120, user_total_sales
  end

  test "should return revenue by seller" do
    seller = users(:juan)
    revenue_by_seller = seller.net_profit
    assert revenue_by_seller > 0
    assert_equal 40, revenue_by_seller
  end

  test "should return commission by seller" do
    seller = users(:juan)
    salary_by_seller = seller.commission
    assert salary_by_seller > 0
    assert_equal 8, salary_by_seller
  end
end
