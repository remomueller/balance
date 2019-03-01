# frozen_string_literal: true

require "test_helper"

SimpleCov.command_name "test:helpers"

# Test to make sure helper methods are working as expected.
class ApplicationHelperTest < ActionView::TestCase
  test "should show billing date" do
    date = Time.zone.today
    entries(:one).billing_date = date.strftime("%Y-%m-%d")
    assert_equal date.strftime("%b %d"), simple_date(entries(:one).billing_date)
  end

  test "should show full billing date from last year" do
    date = Time.zone.today - 1.year
    entries(:one).billing_date = date.strftime("%Y-%m-%d")
    assert_equal date.strftime("%b %d, %Y"), simple_date(entries(:one).billing_date)
  end
end
