require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  fixtures :users
  
  def setup
    @valid = users(:valid)
  end
  
  test "root navigation redirected to login page" do
    get "/"
    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
  
  test "friendly url forwarding after login" do
    get "/entries"
    assert_redirected_to new_user_session_path
    
    sign_in_as(@valid, "123456", "valid-2@example.com")
    assert_equal '/entries', path
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end
end
