require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @account = accounts(:my_bank)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: @account.attributes
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should not create account without name" do
    assert_difference('Account.count', 0) do
      post :create, account: {name: ''}
    end
    assert_not_nil assigns(:account)
    assert_template 'new'
  end

  test "should show account" do
    get :show, id: @account.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account.to_param
    assert_response :success
  end

  test "should update account" do
    put :update, id: @account.to_param, account: @account.attributes
    assert_redirected_to account_path(assigns(:account))
  end

  test "should not update account without name" do
    put :update, id: @account.to_param, account: {name: ''}
    assert_not_nil assigns(:account)
    assert_template 'edit'
  end

  test "should destroy account" do
    assert_difference('Account.current.count', -1) do
      delete :destroy, id: @account.to_param
    end

    assert_redirected_to accounts_path
  end
end
