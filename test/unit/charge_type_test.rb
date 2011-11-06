require 'test_helper'

class ChargeTypeTest < ActiveSupport::TestCase
  test "should permanently delete charge type" do
    assert_difference('ChargeType.count', -1) do
      charge_types(:bank_credit_card).destroy(true)
    end
  end
end
