require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  setup do
    # Nothing
  end

  test "should get version" do
    get :version
    assert_response :success
  end
end
