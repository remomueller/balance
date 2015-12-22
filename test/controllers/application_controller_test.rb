require 'test_helper'

# Main web application controller for Balance
class ApplicationControllerTest < ActionController::TestCase
  test 'should get version' do
    get :version
    assert_response :success
  end

  test 'should get version as json' do
    get :version, format: 'json'
    version = JSON.parse(response.body)
    assert_equal Balance::VERSION::STRING, version['version']['string']
    assert_equal Balance::VERSION::MAJOR, version['version']['major']
    assert_equal Balance::VERSION::MINOR, version['version']['minor']
    assert_equal Balance::VERSION::TINY, version['version']['tiny']
    assert_equal Balance::VERSION::BUILD, version['version']['build']
    assert_response :success
  end
end
