# -*- encoding : utf-8 -*-
require 'test_helper'

class AdminDashboardControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get support" do
    get admin_dashboard_controller_support_url
    assert_response :success
  end

  test "should get alterContent" do
    get admin_dashboard_controller_alterContent_url
    assert_response :success
  end

end
