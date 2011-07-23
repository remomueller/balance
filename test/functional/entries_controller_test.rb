require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @entry = entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post :create, :entry => {:billing_date => '10/29/2000', :charge_type_id => 1, :name => 'Breakfast to Go', :description => 'Coffee from the local coffee shop.', :amount => '5.42'}
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should show entry" do
    get :show, id: @entry.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entry.to_param
    assert_response :success
  end

  test "should update entry" do
    put :update, id: @entry.to_param, :entry => {:billing_date => '10/28/2000', :charge_type_id => 1, :name => 'Lunch', :description => '$10.58 for Lunch at Restaurant', :amount => '10.58'}
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should destroy entry" do
    assert_difference('Entry.current.count', -1) do
      delete :destroy, id: @entry.to_param
    end

    assert_redirected_to entries_path
  end
end
