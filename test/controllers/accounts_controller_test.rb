# frozen_string_literal: true

require 'test_helper'

# Tests to assure that a user can view and modify accounts.
class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:my_bank)
    login(users(:valid))
  end

  def account_params
    {
      name: 'My Bank',
      category: 'savings',
      archived: '0'
    }
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
      post :create, params: { account: account_params }
    end
    assert_redirected_to account_path(Account.last)
  end

  test 'should not create account without name' do
    assert_difference('Account.count', 0) do
      post :create, params: { account: account_params.merge(name: '') }
    end
    assert_not_nil assigns(:account)
    assert_template 'new'
    assert_response :success
  end

  test 'should show account' do
    get :show, params: { id: @account }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @account }
    assert_response :success
  end

  test 'should update account' do
    patch :update, params: { id: @account, account: account_params }
    assert_redirected_to @account
  end

  test 'should not update account with blank name' do
    patch :update, params: {
      id: @account, account: account_params.merge(name: '')
    }
    assert_not_nil assigns(:account)
    assert_template 'edit'
    assert_response :success
  end

  test 'should destroy account' do
    assert_difference('Account.current.count', -1) do
      delete :destroy, params: { id: @account.to_param }
    end
    assert_redirected_to accounts_path
  end
end
