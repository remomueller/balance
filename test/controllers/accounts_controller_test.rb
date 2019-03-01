# frozen_string_literal: true

require "test_helper"

# Tests to assure that a user can view and modify accounts.
class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:my_bank)
    login(users(:valid))
  end

  def account_params
    {
      name: "My Bank",
      category: "savings",
      archived: "0"
    }
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference("ChargeType.count") do
      assert_difference("Account.count") do
        post accounts_url, params: { account: account_params }
      end
    end
    assert_redirected_to account_url(Account.last)
  end

  test "should not create account without name" do
    assert_difference("Account.count", 0) do
      post accounts_url, params: { account: account_params.merge(name: "") }
    end
    assert_response :success
  end

  test "should show account" do
    get account_url(@account)
    assert_response :success
  end

  test "should get edit" do
    get edit_account_url(@account)
    assert_response :success
  end

  test "should update account" do
    patch account_url(@account), params: { account: account_params }
    assert_redirected_to @account
  end

  test "should not update account with blank name" do
    patch account_url(@account), params: {
      account: account_params.merge(name: "")
    }
    assert_response :success
  end

  test "should destroy account" do
    assert_difference("Account.current.count", -1) do
      delete account_url(@account)
    end
    assert_redirected_to accounts_url
  end
end
