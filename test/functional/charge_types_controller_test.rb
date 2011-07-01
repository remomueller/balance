require 'test_helper'

class ChargeTypesControllerTest < ActionController::TestCase
  setup do
    @charge_type = charge_types(:one)
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

  test "should destroy charge type" do
    assert_difference('ChargeType.count', -1) do
      delete :destroy, id: @charge_type.to_param
    end

    assert_redirected_to charge_types_path
  end
end
