require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test "should permanently delete account" do
    assert_difference('Account.count', -1) do
      accounts(:my_bank).destroy(true)
    end
  end
end
