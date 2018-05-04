require 'test_helper'

class DietitianDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get myClients" do
    get dietitian_dashboard_myClients_url
    assert_response :success
  end

  test "should get dietitianProfile" do
    get dietitian_dashboard_dietitianProfile_url
    assert_response :success
  end

  test "should get contactSupport" do
    get dietitian_dashboard_contactSupport_url
    assert_response :success
  end

end
