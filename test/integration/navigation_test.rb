# frozen_string_literal: true

require 'test_helper'

SimpleCov.command_name 'test:integration'

# Tests to assure that user navigation is working as intended.
class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @valid = users(:valid)
  end

  test 'root navigation redirected to login page' do
    get '/'
    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end

  test 'friendly url forwarding after login' do
    get '/entries'
    assert_redirected_to new_user_session_path

    sign_in_as(@valid, '123456')
    assert_equal '/entries', path
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end
end
