# frozen_string_literal: true

require 'test_helper'

# Tests to assure that a user can view and modify accounts.
class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:my_bank)
    login(users(:valid))
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create account' do
    assert_difference('Account.count') do
      post :create, account: @account.attributes
    end

    assert_redirected_to account_path(Account.last)
  end

  test 'should not create account without name' do
    assert_difference('Account.count', 0) do
      post :create, account: { name: '' }
    end
    assert_not_nil assigns(:account)
    assert_template 'new'
    assert_response :success
  end

  test 'should show account' do
    get :show, id: @account
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @account
    assert_response :success
  end

  test 'should update account' do
    put :update, id: @account, account: @account.attributes
    assert_redirected_to @account
  end

  test 'should not update account with blank name' do
    put :update, id: @account, account: { name: '' }
    assert_not_nil assigns(:account)
    assert_template 'edit'
    assert_response :success
  end

  test 'should destroy account' do
    assert_difference('Account.current.count', -1) do
      delete :destroy, id: @account.to_param
    end
    assert_redirected_to accounts_path
  end
end
