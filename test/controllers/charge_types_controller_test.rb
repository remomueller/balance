# frozen_string_literal: true

require "test_helper"

# Tests to assure that charge types can be created and edited.
class ChargeTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login(users(:valid))
    @charge_type = charge_types(:bank_credit_card)
  end

  test "should get index" do
    get charge_types_url
    assert_response :success
  end

  test "should get new" do
    get new_charge_type_url
    assert_response :success
  end

  test "should create charge type" do
    assert_difference("ChargeType.count") do
      post charge_types_url, params: { charge_type: @charge_type.attributes }
    end
    assert_redirected_to charge_type_url(ChargeType.last)
  end

  test "should not create charge type without name" do
    assert_difference("ChargeType.count", 0) do
      post charge_types_url, params: {
        charge_type: {
          name: "",
          account_id: accounts(:my_bank).to_param
        }
      }
    end
    assert_response :success
  end

  test "should show charge type" do
    get charge_type_url(@charge_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_charge_type_url(@charge_type)
    assert_response :success
  end

  test "should update charge type" do
    patch charge_type_url(@charge_type), params: {
      charge_type: @charge_type.attributes
    }
    assert_redirected_to charge_type_url(@charge_type)
  end

  test "should not update charge type without name" do
    patch charge_type_url(@charge_type), params: {
      charge_type: { name: "", account_id: accounts(:my_bank).to_param }
    }
    assert_response :success
  end

  test "should destroy charge type" do
    assert_difference("ChargeType.current.count", -1) do
      delete charge_type_url(@charge_type)
    end
    assert_redirected_to charge_types_url
  end
end
