# frozen_string_literal: true

require 'test_helper'

# Tests to assure that charge types can be created and edited.
class ChargeTypesControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @charge_type = charge_types(:bank_credit_card)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:charge_types)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create charge type' do
    assert_difference('ChargeType.count') do
      post :create, params: { charge_type: @charge_type.attributes }
    end
    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  test 'should not create charge type without name' do
    assert_difference('ChargeType.count', 0) do
      post :create, params: {
        charge_type: {
          name: '',
          account_id: accounts(:my_bank).to_param
        }
      }
    end
    assert_not_nil assigns(:charge_type)
    assert_template 'new'
    assert_response :success
  end

  test 'should show charge type' do
    get :show, params: { id: @charge_type }
    assert_response :success
  end

  test 'should get edit' do
    get :edit, params: { id: @charge_type }
    assert_response :success
  end

  test 'should update charge type' do
    put :update, params: {
      id: @charge_type,
      charge_type: @charge_type.attributes
    }
    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  test 'should not update charge type without name' do
    put :update, params: {
      id: @charge_type,
      charge_type: { name: '', account_id: accounts(:my_bank).to_param }
    }
    assert_not_nil assigns(:charge_type)
    assert_template 'edit'
    assert_response :success
  end

  test 'should destroy charge type' do
    assert_difference('ChargeType.current.count', -1) do
      delete :destroy, params: { id: @charge_type }
    end
    assert_redirected_to charge_types_path
  end
end
