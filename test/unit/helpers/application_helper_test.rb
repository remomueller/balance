require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "should show billing date" do
    date = Date.today
    entries(:one).billing_date = date.strftime("%Y-%m-%d")
    assert_equal date.strftime("%b %d"), simple_date(entries(:one).billing_date)
  end
  
  test "should show full billing date from last year" do
    date = Date.today - 1.year
    entries(:one).billing_date = date.strftime("%Y-%m-%d")
    assert_equal date.strftime("%b %d, %Y"), simple_date(entries(:one).billing_date)
  end
end
