# frozen_string_literal: true

require "test_helper"

# Tests for modifying and displaying entries.
class EntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login(users(:valid))
    @entry = entries(:one)
  end

  def entry_params
    {
      billing_date: "10/29/2000",
      charge_type_id: charge_types(:bank_credit_card).to_param,
      name: "Breakfast to Go",
      description: "Coffee from the local coffee shop.",
      decimal_amount: "5.42"
    }
  end

  test "should get calendar" do
    get calendar_entries_url
    assert_response :success
  end

  test "should get calendar with month and year" do
    get calendar_entries_url, params: { month: 1, year: 2011 }
    assert_response :success
  end

  test "should get calendar with js" do
    get calendar_entries_url(format: "js"), params: { month: 1, year: 2011 }, xhr: true
    assert_response :success
  end

  test "should get calendar with js without month and year" do
    get calendar_entries_url(format: "js"), xhr: true
    assert_response :success
  end

  test "should get overview" do
    get overview_entries_url
    assert_response :success
  end

  test "should get earning spending graph" do
    get earning_spending_graph_entries_url(format: "js"), params: { year: 2011 }, xhr: true
    assert_response :success
  end

  test "should get index" do
    get entries_url
    assert_response :success
  end

  test "should get new" do
    get new_entry_url
    assert_response :success
  end

  test "should copy existing" do
    get copy_entry_url(@entry)
    assert_response :success
  end

  test "should not copy existing with invalid id" do
    get copy_entry_url(-1)
    assert_redirected_to new_entry_url
  end

  test "should create entry" do
    assert_difference("Entry.count") do
      post entries_url, params: { entry: entry_params }
    end
    assert_redirected_to Entry.last
  end

  test "should create entry from calendar" do
    assert_difference("Entry.count") do
      post entries_url(format: "js"), params: { entry: entry_params }
    end
    assert_response :success
  end

  test "should create entry with amount that contains whitespace" do
    assert_difference("Entry.count") do
      post entries_url, params: { entry: entry_params.merge(decimal_amount: " 5.42 ") }
    end
    assert_equal 542, Entry.last.amount
    assert_redirected_to Entry.last
  end

  test "should create entry with amount that contains commas" do
    assert_difference("Entry.count") do
      post entries_url, params: { entry: entry_params.merge(decimal_amount: "5,235.42") }
    end
    assert_equal 523_542, Entry.last.amount
    assert_redirected_to Entry.last
  end

  test "should create entry with amount that contains dollar sign" do
    assert_difference("Entry.count") do
      post entries_url, params: { entry: entry_params.merge(decimal_amount: "$3.00") }
    end
    assert_equal 300, Entry.last.amount
    assert_redirected_to Entry.last
  end

  test "should not create entry without name" do
    assert_difference("Entry.count", 0) do
      post entries_url, params: { entry: entry_params.merge(name: "") }
    end
    assert_response :success
  end

  test "should not create entry with invalid decimal amount" do
    assert_difference("Entry.count", 0) do
      post entries_url, params: { entry: entry_params.merge(decimal_amount: "$ 5.42 invalid characters") }
    end
    assert_response :success
  end

  test "should show entry" do
    get entry_url(@entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_entry_url(@entry)
    assert_response :success
  end

  test "should update entry" do
    patch entry_url(@entry), params: {
      entry: {
        billing_date: "10/28/2000",
        charge_type_id: charge_types(:bank_credit_card).to_param,
        name: "Lunch",
        description: "$10.58 for Lunch at Restaurant",
        decimal_amount: "10.58"
      }
    }
    assert_redirected_to @entry
  end

  test "should not update entry without name" do
    patch entry_url(@entry), params: {
      entry: {
        billing_date: "10/28/2000",
        charge_type_id: charge_types(:bank_credit_card).to_param,
        name: "",
        description: "",
        decimal_amount: "10.58"
      }
    }
    assert_response :success
  end

  test "should move entry on calendar" do
    post move_entry_url(@entry, format: "js"), params: {
      entry: { billing_date: "03/07/2012" }
    }
    @entry.reload
    assert_equal "03/07/2012", @entry.billing_date.strftime("%m/%d/%Y")
    assert_response :success
  end

  test "should not move entry without billing date" do
    post move_entry_url(@entry, format: "js"), params: {
      entry: { billing_date: "" }
    }
    @entry.reload
    assert_equal "10/28/2000", @entry.billing_date.strftime("%m/%d/%Y")
    assert_response :success
  end

  test "should destroy entry" do
    assert_difference("Entry.current.count", -1) do
      delete entry_url(@entry)
    end
    assert_redirected_to entries_url
  end

  test "should mark entry charged" do
    post mark_charged_entry_url(@entry, format: "js")
    @entry.reload
    assert_equal true, @entry.charged
    assert_response :success
  end

  test "should autocomplete based on search" do
    get autocomplete_entries_url(format: "js"), params: { term: "lunch" }
    assert_response :success
  end

  test "should get averages" do
    get averages_entries_url
    assert_response :success
  end

  test "should get current balance" do
    get current_balance_entries_url
    assert_response :success
  end
end
