require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :users

  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_allow_signup
    assert_difference 'Users.count' do
      create_users
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Users.count' do
      create_users(:login => nil)
      assert assigns(:users).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Users.count' do
      create_users(:password => nil)
      assert assigns(:users).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Users.count' do
      create_users(:password_confirmation => nil)
      assert assigns(:users).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Users.count' do
      create_users(:email => nil)
      assert assigns(:users).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_users(options = {})
      post :create, :users => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire', :password_confirmation => 'quire' }.merge(options)
    end
end
