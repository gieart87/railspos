require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get sales" do
    get reports_sales_url
    assert_response :success
  end

  test "should get revenue" do
    get reports_revenue_url
    assert_response :success
  end

end
