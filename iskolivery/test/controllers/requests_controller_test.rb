require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get view" do
    get requests_view_url
    assert_response :success
  end

end
