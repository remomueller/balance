require 'test_helper'

class ChargeTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:charge_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_charge_type
    assert_difference('ChargeType.count') do
      post :create, :charge_type => { }
    end

    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  def test_should_show_charge_type
    get :show, :id => charge_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => charge_types(:one).id
    assert_response :success
  end

  def test_should_update_charge_type
    put :update, :id => charge_types(:one).id, :charge_type => { }
    assert_redirected_to charge_type_path(assigns(:charge_type))
  end

  def test_should_destroy_charge_type
    assert_difference('ChargeType.count', -1) do
      delete :destroy, :id => charge_types(:one).id
    end

    assert_redirected_to charge_types_path
  end
end
