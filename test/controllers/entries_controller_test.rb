require 'test_helper'

# Tests for modifying and displaying entries
class EntriesControllerTest < ActionController::TestCase
  setup do
    login(users(:valid))
    @entry = entries(:one)
  end

  test 'should get calendar' do
    get :calendar
    assert_template 'calendar'
    assert_response :success
  end

  test 'should get calendar with month and year' do
    get :calendar, month: 1, year: 2011
    assert_template 'calendar'
    assert_response :success
  end

  test 'should get calendar with js' do
    xhr :get, :calendar, month: 1, year: 2011, format: 'js'
    assert_template 'calendar'
    assert_response :success
  end

  test 'should get calendar with js without month and year' do
    xhr :get, :calendar, format: 'js'
    assert_template 'calendar'
    assert_response :success
  end

  test 'should get overview' do
    get :overview
    assert_not_nil assigns(:gross_spending)
    assert_not_nil assigns(:gross_income)
    assert_not_nil assigns(:net_profit)
    assert assigns(:gross_spending).is_a?(Array)
    assert assigns(:gross_income).is_a?(Array)
    assert assigns(:net_profit).is_a?(Array)
    assert_template 'overview'
  end

  test 'should get earning spending graph' do
    xhr :get, :earning_spending_graph, year: 2011, format: 'js'
    assert_not_nil assigns(:gross_spending)
    assert_not_nil assigns(:gross_income)
    assert_not_nil assigns(:net_profit)
    assert assigns(:gross_spending).is_a?(Array)
    assert assigns(:gross_income).is_a?(Array)
    assert assigns(:net_profit).is_a?(Array)
    assert_template 'earning_spending_graph'
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should copy existing' do
    get :copy, id: @entry
    assert_not_nil assigns(:entry)
    assert_equal @entry.name, assigns(:entry).name
    assert_equal @entry.description, assigns(:entry).description
    assert_nil assigns(:entry).billing_date
    assert_equal @entry.charged, assigns(:entry).charged
    assert_equal @entry.charge_type, assigns(:entry).charge_type
    assert_equal @entry.amount, assigns(:entry).amount
    assert_template 'new'
    assert_response :success
  end

  test 'should not copy existing with invalid id' do
    get :copy, id: -1
    assert_nil assigns(:entry)
    assert_redirected_to new_entry_path
  end

  test 'should create entry' do
    assert_difference('Entry.count') do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast to Go', description: 'Coffee from the local coffee shop.', decimal_amount: '5.42' }
    end

    assert_redirected_to entry_path(assigns(:entry))
  end

  test 'should create entry from calendar' do
    assert_difference('Entry.count') do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast to Go', description: 'Coffee from the local coffee shop.', decimal_amount: '5.42' }, format: 'js'
    end

    assert_not_nil assigns(:entry)
    # assert_not_nil assigns(:entries)

    assert_template 'create'
    assert_response :success
  end

  test 'should create entry with amount that contains whitespace' do
    assert_difference('Entry.count') do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast to Go', description: 'Coffee from the local coffee shop.', decimal_amount: ' 5.42 ' }
    end

    assert_not_nil assigns(:entry)
    assert_equal 542, assigns(:entry).amount

    assert_redirected_to entry_path(assigns(:entry))
  end

  test 'should create entry with amount that contains commas' do
    assert_difference('Entry.count') do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast to Go', description: 'Coffee from the local coffee shop.', decimal_amount: '5,235.42' }
    end

    assert_not_nil assigns(:entry)
    assert_equal 523542, assigns(:entry).amount

    assert_redirected_to entry_path(assigns(:entry))
  end

  test 'should create entry with amount that contains dollar sign' do
    assert_difference('Entry.count') do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast to Go', description: 'Coffee from the local coffee shop.', decimal_amount: '$3.00' }
    end

    assert_not_nil assigns(:entry)
    assert_equal 300, assigns(:entry).amount

    assert_redirected_to entry_path(assigns(:entry))
  end

  test 'should not create entry without name' do
    assert_difference('Entry.count', 0) do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: '', description: '', decimal_amount: '5.42' }
    end

    assert_not_nil assigns(:entry)

    assert_template 'new'
  end

  test 'should not create entry with invalid decimal amount' do
    assert_difference('Entry.count', 0) do
      post :create, entry: { billing_date: '10/29/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Breakfast', description: '', decimal_amount: '$ 5.42 invalid characters' }
    end
    assert_not_nil assigns(:entry)
    assert_template 'new'
  end

  test 'should show entry' do
    get :show, id: @entry
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @entry
    assert_response :success
  end

  test 'should update entry' do
    put :update, id: @entry, entry: { billing_date: '10/28/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: 'Lunch', description: '$10.58 for Lunch at Restaurant', decimal_amount: '10.58' }
    assert_redirected_to entry_path(assigns(:entry))
  end

  test 'should not update entry without name' do
    put :update, id: @entry, entry: { billing_date: '10/28/2000', charge_type_id: charge_types(:bank_credit_card).to_param, name: '', description: '', decimal_amount: '10.58' }
    assert_not_nil assigns(:entry)
    assert_template 'edit'
  end

  test 'should move entry on calendar' do
    post :move, id: @entry, entry: { billing_date: '03/07/2012' }, format: 'js'
    assert_not_nil assigns(:entry)
    assert_equal '03/07/2012', assigns(:entry).billing_date.strftime('%m/%d/%Y')
    assert_template 'update'
    assert_response :success
  end

  test 'should not move entry without billing date' do
    post :move, id: @entry, entry: { billing_date: '' }, format: 'js'
    assert_not_nil assigns(:entry)
    assert_equal '10/28/2000', assigns(:entry).billing_date.strftime('%m/%d/%Y')
    assert_template 'update'
    assert_response :success
  end

  test 'should destroy entry' do
    assert_difference('Entry.current.count', -1) do
      delete :destroy, id: @entry
    end

    assert_redirected_to entries_path
  end

  test 'should mark entry charged' do
    post :mark_charged, id: @entry, format: 'js'
    assert_equal true, assigns(:entry).charged
    assert_template 'mark_charged'
  end

  test 'should autocomplete based on search' do
    get :autocomplete, term: 'lunch', format: 'js'
    assert assigns(:entry_names)
    assert (assigns(:entry_names).size <= 8)
    assert_response :success
  end

  test 'should get averages' do
    get :averages
    assert_template 'averages'
    assert_response :success
  end

  test 'should get current balance' do
    get :current_balance
    assert_template 'current_balance'
    assert_response :success
  end
end
