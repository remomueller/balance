require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @entry = entries(:one)
  end

  test "should get overview" do
    get :overview
    assert_not_nil assigns(:today)
    assert_not_nil assigns(:year)
    assert_not_nil assigns(:month)
    assert_not_nil assigns(:entries)
    assert_not_nil assigns(:gross_spending)
    assert_not_nil assigns(:gross_income)
    assert_not_nil assigns(:net_profit)
    assert assigns(:entries).kind_of?(Array)
    assert assigns(:gross_spending).kind_of?(Array)
    assert assigns(:gross_income).kind_of?(Array)
    assert assigns(:net_profit).kind_of?(Array)
    assert_template 'overview'
  end

  test "should get earning spending graph" do
    get :earning_spending_graph, :month => 1, :year => 2011, :format => 'js'
    assert_not_nil assigns(:year)
    assert_not_nil assigns(:month)
    assert_not_nil assigns(:entries)
    assert_not_nil assigns(:gross_spending)
    assert_not_nil assigns(:gross_income)
    assert_not_nil assigns(:net_profit)
    assert assigns(:entries).kind_of?(Array)
    assert assigns(:gross_spending).kind_of?(Array)
    assert assigns(:gross_income).kind_of?(Array)
    assert assigns(:net_profit).kind_of?(Array)
    assert_template 'earning_spending_graph'
  end

  test "should not get earning spending graph without month and year" do
    get :earning_spending_graph, :format => 'js'
    assert_not_nil assigns(:year)
    assert_not_nil assigns(:month)
    assert_nil assigns(:entries)
    assert_nil assigns(:gross_spending)
    assert_nil assigns(:gross_income)
    assert_nil assigns(:net_profit)
    assert_response :success
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
      post :create, :entry => {:billing_date => '10/29/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => 'Breakfast to Go', :description => 'Coffee from the local coffee shop.', :decimal_amount => '5.42'}
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should create entry and redirect to calendar overview" do
    assert_difference('Entry.count') do
      post :create, :entry => {:billing_date => '10/29/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => 'Breakfast to Go', :description => 'Coffee from the local coffee shop.', :decimal_amount => '5.42'}, :from_calendar => '1'
    end

    assert_not_nil assigns(:entry)
    assert_redirected_to dashboard_path(:month => assigns(:entry).billing_date.month, :year => assigns(:entry).billing_date.year)
  end

  test "should not create entry without name" do
    assert_difference('Entry.count', 0) do
      post :create, :entry => {:billing_date => '10/29/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => '', :description => '', :decimal_amount => '5.42'}
    end
    
    assert_not_nil assigns(:entry)

    assert_template 'new'
  end

  test "should not create entry with invalid decimal amount" do
    assert_difference('Entry.count', 0) do
      post :create, :entry => {:billing_date => '10/29/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => 'Breakfast', :description => '', :decimal_amount => '$ 5.42'}
    end
    assert_not_nil assigns(:entry)
    assert_template 'new'
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
    put :update, id: @entry.to_param, :entry => {:billing_date => '10/28/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => 'Lunch', :description => '$10.58 for Lunch at Restaurant', :decimal_amount => '10.58'}
    assert_redirected_to entry_path(assigns(:entry))
  end

  test "should not update entry without name" do
    put :update, id: @entry.to_param, :entry => {:billing_date => '10/28/2000', :charge_type_id => charge_types(:bank_credit_card).to_param, :name => '', :description => '', :decimal_amount => '10.58'}
    assert_not_nil assigns(:entry)
    assert_template 'edit'
  end

  test "should destroy entry" do
    assert_difference('Entry.current.count', -1) do
      delete :destroy, id: @entry.to_param
    end

    assert_redirected_to entries_path
  end
  
  test "should mark entry charged" do
    post :mark_charged, id: @entry.to_param, :format => 'js'
    assert_equal true, assigns(:entry).charged
    assert_template 'mark_charged'
  end
  
  test "should autocomplete based on search" do
    get :autocomplete, :term => 'lunch', :format => 'js'
    assert assigns(:entries)
    assert (assigns(:entries).size <= 8)
    assert_template 'autocomplete'
  end
  
  test "should get averages" do
    get :averages
    assert_template 'averages'
    assert_response :success
  end
  
  test "should get current balance" do
    get :current_balance
    assert_template 'current_balance'
    assert_response :success
  end
  
end
