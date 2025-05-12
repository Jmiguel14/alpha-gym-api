require "test_helper"

class SaleTest < ActiveSupport::TestCase
  test "should return sales revenue by seller" do
    seller = users(:gaby)
    start_date = Date.parse("2025-03-01")
    end_date = Date.parse("2025-03-02")
    user_total_sales = seller.total_sales_revenue(start_date, end_date)
    assert user_total_sales > 0
    assert_equal 320, user_total_sales
  end

  test "should return revenue by seller" do
    seller = users(:gaby)
    start_date = Date.parse("2025-03-01")
    end_date = Date.parse("2025-03-02")
    revenue_by_seller = seller.net_profit(start_date, end_date)
    assert revenue_by_seller > 0
    assert_equal 240, revenue_by_seller
  end

  test "should return commission by seller" do
    seller = users(:gaby)
    start_date = Date.parse("2025-03-01")
    end_date = Date.parse("2025-03-02")
    salary_by_seller = seller.commission(start_date, end_date)
    assert salary_by_seller > 0
    assert_equal 48, salary_by_seller
  end
end
