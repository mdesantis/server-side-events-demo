require 'test_helper'

class ServerSideEventsControllerTest < ActionController::TestCase
  test "should get test" do
    get :test
    assert_response :success
  end

end
