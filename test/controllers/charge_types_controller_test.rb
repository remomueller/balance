# frozen_string_literal: true

require 'test_helper'

# Tests to assure that charge types can be created and edited.
class ChargeTypesControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @charge_type = charge_types(:bank_credit_card)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:charge_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create charge type" do
    assert_difference('ChargeType.count') do
      post :create, charge_type: @charge_type.attributes
    end

    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  test "should not create charge type without name" do
    assert_difference('ChargeType.count', 0) do
      post :create, charge_type: {name: '', account_id: accounts(:my_bank).to_param}
    end

    assert_not_nil assigns(:charge_type)
    assert_template 'new'
  end

  test "should show charge type" do
    get :show, id: @charge_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @charge_type.to_param
    assert_response :success
  end

  test "should update charge type" do
    put :update, id: @charge_type.to_param, charge_type: @charge_type.attributes
    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  test "should not update charge type without name" do
    put :update, id: @charge_type.to_param, charge_type: {name: '', account_id: accounts(:my_bank).to_param}
    assert_not_nil assigns(:charge_type)
    assert_template 'edit'
  end

  test "should destroy charge type" do
    assert_difference('ChargeType.current.count', -1) do
      delete :destroy, id: @charge_type.to_param
    end

    assert_redirected_to charge_types_path
  end
end
