# frozen_string_literal: true

require 'test_helper'

SimpleCov.command_name 'test:controllers'

# Main web application controller for Balance.
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
    if Balance::VERSION::BUILD.nil?
      assert_nil version['version']['build']
    else
      assert_equal Balance::VERSION::BUILD, version['version']['build']
    end
    assert_response :success
  end
end
