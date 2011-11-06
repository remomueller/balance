require 'test_helper'

SimpleCov.command_name "test:functionals"

class UsersControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    # @user = users(:one)
  end

  test "should get dashboard" do
    get :dashboard
    assert_template 'dashboard'
    assert_response :success
  end
  
  test "should get dashboard with month and year" do
    get :dashboard, :month => 1, :year => 2011
    assert_template 'dashboard'
    assert_response :success
  end

  # TODO: Calling dashboard without month and year
  test "should get dashboard with js" do
    get :dashboard, :month => 1, :year => 2011, :format => 'js'
    assert_template 'dashboard'
    assert_response :success
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:users)
  # end
  # 
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  # 
  # test "should create user" do
  #   assert_difference('User.count') do
  #     post :create, user: @user.attributes
  #   end
  # 
  #   assert_redirected_to user_path(assigns(:user))
  # end
  # 
  # test "should show user" do
  #   get :show, id: @user.to_param
  #   assert_response :success
  # end
  # 
  # test "should get edit" do
  #   get :edit, id: @user.to_param
  #   assert_response :success
  # end
  # 
  # test "should update user" do
  #   put :update, id: @user.to_param, user: @user.attributes
  #   assert_redirected_to user_path(assigns(:user))
  # end
  # 
  # test "should destroy user" do
  #   assert_difference('User.current.count', -1) do
  #     delete :destroy, id: @user.to_param
  #   end
  # 
  #   assert_redirected_to users_path
  # end
end
