require 'test_helper'

class EntryTest < ActiveSupport::TestCase
  test "should permanently delete entry" do
    assert_difference('Entry.count', -1) do
      entries(:one).destroy(true)
    end
  end
end
