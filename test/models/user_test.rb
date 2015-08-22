require 'test_helper'

SimpleCov.command_name "test:models"

class UserTest < ActiveSupport::TestCase

  test "should get total expenditures" do
    assert users(:valid).total_expenditures.kind_of?(Fixnum)
  end

  test "should get average expenditures per day" do
    assert users(:valid).average_expenditures_per_day.kind_of?(String)
  end

  test "should get average expenditures per month" do
    assert users(:valid).average_expenditures_per_month.kind_of?(String)
  end

  test "should get average expenditures per year" do
    assert users(:valid).average_expenditures_per_year.kind_of?(String)
  end

  test "should get reverse name" do
    assert_equal 'LastName, FirstName', users(:valid).reverse_name
  end

end
